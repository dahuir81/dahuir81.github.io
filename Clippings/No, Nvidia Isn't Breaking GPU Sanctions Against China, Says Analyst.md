---
title: "No, Nvidia Isn't Breaking GPU Sanctions Against China, Says Analyst"
source: "https://www.tomshardware.com/news/no-nvidia-isnt-breaking-gpu-sanctions-analyst"
author:
  - "[[Anton Shilov]]"
published: 2023-11-12
created: 2026-04-11
description: "New U.S. export rules for AI and HPC processors explained."
tags:
  - "clippings"
---
![Nvidia](https://cdn.mos.cms.futurecdn.net/Ld4LzickFJXm6reK7vAXLA-1280-80.png.webp)

(Image credit: Nvidia)

The [rumored new lineup of artificial intelligence (AI) and high-performance computing (HPC) GPUs](https://www.tomshardware.com/tech-industry/nvidia-readies-new-ai-and-hpc-gpus-for-china-market-report) from Nvidia is perfectly aligned with the newest expanded export rules published by the U.S. Department of Commerce in mid-October, believes [Patrick Moorhead](https://moorinsightsstrategy.com/research-notes/do-you-really-think-nvidia-would-skirt-usg-export-controls-on-china-accelerators-think-again/), the head of Moor Insights and Strategy. He points out that, unlike some reports in the press, the company is not trying to evade the expanded U.S. sanctions on AI processors with its new data center GPUs. Meanwhile, the DoC recently explained which products cannot be shipped to China without a license, even if they are not designed for data centers, and the [GeForce RTX 4090](https://www.tomshardware.com/reviews/nvidia-geforce-rtx-4090-review) is seemingly one of them.  
  
"Yesterday, there were a flurry of articles written I thought suggested or were interpreted that Nvidia was trying to 'skirt' or 'pull a fast one' on the U.S. Government Export Control laws with a rumored line of new datacenter accelerator cards for China export," Moor [wrote](https://moorinsightsstrategy.com/research-notes/do-you-really-think-nvidia-would-skirt-usg-export-controls-on-china-accelerators-think-again/) in a blog post. "I find this laughable. The downside for Nvidia would be immense. The company may be a fierce innovator and competitor, but they are not dumb."

![U.S. Department of Commerce](https://cdn.mos.cms.futurecdn.net/dHjnhPMk93HuDPBYnXBzLV-1200-80.png.webp)

(Image credit: U.S. Department of Commerce)

## Total Processing Performance

By performance, the new rules define the **Total Processing Performance (TPP)** score, essentially listed processing power multiplied by the length of operation (e.g., **FLOPS or TOPS of 8/16/32/64 bits**) without sparsity. The U.S. government does not want China to obtain processors — whether intended for data centers or client PCs — with a TPP score of 4800 without sparsity (in the case of matrix multiplication).  
  
For example, Nvidia’s H100 has a listed FP16/BF16 performance of 989 TFLOPS with sparsity. Divide by two and multiply by 16 and you get its TPP score of 7,912, making it far too powerful for export to China.  
  
This is why Nvidia’s GeForce RTX 4090/ [AD102](https://images.nvidia.com/aem-dam/Solutions/Data-Center/l4/nvidia-ada-gpu-architecture-whitepaper-v2.1.pdf) — one of the [best graphics cards](https://www.tomshardware.com/reviews/best-gpus,4380.html) around — also falls into the category of export-licensable items. Its FP8 Tensor FLOPS performance (660 TFLOPS) hits a TPP score of 5,280. So, no, [Nvidia and its partners cannot ship the GeForce RTX 4090 to China](https://www.tomshardware.com/pc-components/gpus/nvidia-rtx-4090-subject-to-china-export-restrictions-starting-november-17), effective November 16.

## Performance Density

Another parameter the latest rules introduce is a **Performance Density (PD)** metric. This parameter is designed to avoid the loophole of acquiring numerous smaller data center AI chips, which, if combined, would be as powerful as restricted chips. PD is counted by **dividing TPP by the die area measured in square millimeters**. The die area includes built-in caches but excludes external memory devices like HBMs. This one is designed for minor high-density chips with a TPP score between 1600 and 4800.  
  
For example, Nvidia’s L4/ [AD104](https://images.nvidia.com/aem-dam/Solutions/Data-Center/l4/nvidia-ada-gpu-architecture-whitepaper-v2.1.pdf) datacenter GPU has a TPP score of 1936 (242 FP8 TFLOPS \* 8 = 1,936). Yet, its die size is 294 mm^2. Therefore, its performance density is 6.5, so the L4 cannot be shipped to China. Meanwhile, Nvidia’s [GeForce RTX 4070 Ti](https://www.tomshardware.com/reviews/nvidia-geforce-rtx-4070-ti-review-a-costly-70-class-gpu) — a non-datacenter product with a TPP score of 1936 — can be sent to China without restrictions.

## The Interpretation

The exciting part here is the government's interpretation of whether a product is designed for data center use or not. In this case, the U.S. DoC plans to assess the destination of the particular product based on its characteristics instead of its branding. For example, a dual-slot GeForce RTX 4070 Ti with a blower or passive heatsink would be considered a data center board, no matter what it is formally called.  
  
"Even if the manufacturer is not marketing the item for data center use, the item may still be designed for data center use based on the technical characteristics of the item," said Thea D. Rozman Kendler, assistant secretary of the U.S. Department of Commerce Bureau of Industry and [Security](https://www.tomshardware.com/tag/security).

## Nvidia's (Alleged) China Data Center GPU Lineup

After the U.S. Department of Commerce published its new export rules for data center processors used for AI and HPC workloads in mid-October, they appeared so severe that almost no high-performance hardware could be sent to China and other countries. Nvidia, Intel, and AMD ship tons of AI and HPC hardware to Chinese customers, and losing those sales will cost them billions in revenue. This is why rumors started to spread that Nvidia was tricking the U.S. govt with its rumored lineup of data center products tailored specifically for the Chinese market.

Swipe to scroll horizontally

<table><thead><tr><th colspan="1">GPU</th><th colspan="1">HGX H20</th><th colspan="1">L20 PCle</th><th colspan="1">L2 PCle</th></tr></thead><tbody><tr><td colspan="1">Architecture | GPU</td><td colspan="1">Hopper | GH100</td><td colspan="1">Ada Lovelace | AD102</td><td colspan="1">Ada Lovelace | AD104</td></tr><tr><td colspan="1">Memory</td><td colspan="1">96 GB HBM3</td><td colspan="1">48 GB GDDR6 w/ ECC</td><td colspan="1">24 GB GDDR6 w/ ECC</td></tr><tr><td colspan="1">Total Processing Power (FP16/BF16)</td><td colspan="1">2,368</td><td colspan="1">1,912</td><td colspan="1">1,544</td></tr><tr><td colspan="1">Performance Density</td><td colspan="1">2.9</td><td colspan="1">3.13</td><td colspan="1">5.2</td></tr><tr><td colspan="1">Memory Bandwidth</td><td colspan="1">4.0 TB/s</td><td colspan="1">864 GB/s</td><td colspan="1">300 GB/s</td></tr><tr><td colspan="1">INT8 I FP8 Tensor</td><td colspan="1">296 I 296 TFLOPS</td><td colspan="1">239 I 239 TFLOPS</td><td colspan="1">193 I 193 TFLOPS</td></tr><tr><td colspan="1">BF16 I FP16 Tensor</td><td colspan="1">148 I 148 TFLOPS</td><td colspan="1">119.5 I 119.5 TFLOPS</td><td colspan="1">96.5 I 96.5 TFLOPS</td></tr><tr><td colspan="1">TF32 Tensor</td><td colspan="1">74 TFLOPS</td><td colspan="1">59.8 TFLOPS</td><td colspan="1">48.3 TFLOPS</td></tr><tr><td colspan="1">FP32</td><td colspan="1">44 TFLOPS</td><td colspan="1">59.8 TFLOPS</td><td colspan="1">24.1 TFLOPS</td></tr><tr><td colspan="1">FP64</td><td colspan="1">1 TFLOPS</td><td colspan="1">N/A</td><td colspan="1">N/A</td></tr><tr><td colspan="1">RT Core</td><td colspan="1">N/A</td><td colspan="1">Yes</td><td colspan="1">Yes</td></tr><tr><td colspan="1">MIG</td><td colspan="1">Up to 7 MIG</td><td colspan="1">N/A</td><td colspan="1">N/A</td></tr><tr><td colspan="1">L2 Cache</td><td colspan="1">60 MB</td><td colspan="1">96 MB</td><td colspan="1">36 MB</td></tr><tr><td colspan="1">Media Engine</td><td colspan="1">7 NVDEC, 7 NVJPEG</td><td colspan="1">3 NVENC (+AV1), 3 NVDEC, 4 NVJPEG</td><td colspan="1">2 NVENC (AVI), 4 NVDEC, 4 NVJPEG</td></tr><tr><td colspan="1">Power</td><td colspan="1">400 W</td><td colspan="1">275W</td><td colspan="1">TBD</td></tr><tr><td colspan="1">Form Factor</td><td colspan="1">8-way HGX</td><td colspan="1">2-slot FHFL</td><td colspan="1">1-slot LP</td></tr><tr><td colspan="1">Interface</td><td colspan="1">PCIe Gen5 x16: 128 GB/s</td><td colspan="1">PCle Gen4 x16: 64 GB/s</td><td colspan="1">PCle Gen4 x16: 64 GB/s</td></tr><tr><td colspan="1">NVLink</td><td colspan="1">900 GB/s</td><td colspan="1">-</td><td colspan="1">-</td></tr><tr><td colspan="1">Samples</td><td colspan="1">November 2023</td><td colspan="1">November 2023</td><td colspan="1">November 2023</td></tr><tr><td colspan="1">Production</td><td colspan="1">December 2023</td><td colspan="1">December 2023</td><td colspan="1">December 2023</td></tr></tbody></table>

A close look at Nvidia's alleged data center product lineup for China reveals that the family is meticulously designed to avoid any possible violations of the latest U.S. export rules concerning AI and HPC GPUs. The new offerings are designed to fit into the green zone in the chart, thus complying with US sanctions against China while allowing Nvidia to recoup some of its [lost $5 billion in sales](https://www.tomshardware.com/news/nvidia-to-re-allocate-dollar5-billion-worth-of-gpus-thanks-to-us-export-rules-report) in the increasingly restricted Chinese market.