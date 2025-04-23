#!/usr/bin/env node

const fs = require('fs');
const path = require('path');
const sharp = require('sharp');
const pixelmatch = require('pixelmatch').default;

// 获取命令行参数
const imageDir = process.argv[2];

if (!imageDir) {
    console.error('请提供图片目录路径');
    process.exit(1);
}

// 获取目录下的所有图片文件
function getImageFiles(dir) {
    return fs.readdirSync(dir)
        .filter(file => /\.(jpg|jpeg|png|gif)$/i.test(file))
        .map(file => path.join(dir, file))
        .sort();
}

// 读取图片并转换为Buffer
async function readImage(file) {
    try {
        // 使用sharp处理图片
        const { data, info } = await sharp(file)
            .ensureAlpha()
            .raw()
            .toBuffer({ resolveWithObject: true });
            
        
        if (data.length !== info.width * info.height * info.channels) {
            throw new Error('Data length does not match image dimensions');
        }
        
        return {
            data: new Uint8Array(data),
            width: info.width,
            height: info.height
        };
    } catch (error) {
        console.error(`读取图片失败: ${file}`, error);
        throw error;
    }
}

// 比较两张图片的相似度
async function compareImages(image1, image2) {
    try {
        const img1 = await readImage(image1);
        const img2 = await readImage(image2);

        // 确保两张图片尺寸相同
        if (img1.width !== img2.width || img1.height !== img2.height) {
            console.log('尺寸不同，认为完全不相似');
            return 100; // 尺寸不同，认为完全不相似
        }

        // 创建输出缓冲区
        const diff = new Uint8Array(img1.width * img1.height * 4);
        
        // 比较图片
        const numDiffPixels = pixelmatch(
            img1.data,
            img2.data,
            diff,
            img1.width,
            img1.height,
            { threshold: 0.1, includeAA: false }
        );

        // 计算不相似度百分比
        const totalPixels = img1.width * img1.height;
        return (numDiffPixels / totalPixels) * 100;
    } catch (error) {
        console.error(`比较图片时出错: ${error.message}`);
        return 100; // 出错时认为不相似
    }
}

// 处理图片比较和删除
async function processImages(imageFiles) {
    let currentIndex = 0;
    let nextIndex = 1;

    while (nextIndex < imageFiles.length) {
        const currentImage = imageFiles[currentIndex];
        const nextImage = imageFiles[nextIndex];

        console.log(`比较: ${path.basename(currentImage)} 和 ${path.basename(nextImage)}`);
        const similarity = await compareImages(currentImage, nextImage);
        console.log(`相似度: ${similarity}`);
        
        if (similarity < 1) { // 相似度高于99%
            console.log(`删除相似图片: ${path.basename(nextImage)}`);
            fs.unlinkSync(nextImage);
            imageFiles.splice(nextIndex, 1);
            // 强制垃圾回收
            if (global.gc) {
                global.gc();
            }
        } else {
            currentIndex++;
            nextIndex++;
        }
    }
}

// 主函数
async function main() {
    try {
        const imageFiles = getImageFiles(imageDir);
        console.log(`找到 ${imageFiles.length} 张图片`);

        await processImages(imageFiles);
        console.log('处理完成');
    } catch (error) {
        console.error('发生错误:', error);
    }
}

// 运行主函数
main().catch(console.error);






