+++
categories = ["PIM"]
coders = ["Jaseci-Labs"]
date = 2022-10-17T23:32:51-04:00
description = ""
github = ["https://github.com/Jaseci-Labs/jaseci"]
image = "https://statics.patrickli.one/blog/portfolio/jaseci.png"
title = "JacPIM"
type = "post"
+++

Over the last decade, memory bandwidth has emerged as a dominant performance bottleneck across many applications, as the demand for large-scale data processing continues to grow. Processing-in-Memory (PIM) has been proposed as a way to mitigate this “memory wall” by placing computational logic near the memory device, thereby reducing costly data movement.

While PIM has demonstrated strong benefits for memory-bound workloads, prior research has largely focused on domain-specific accelerators, such as AI inference engines. In contrast, general-purpose adoption of PIM remains limited, primarily because PIM devices are notoriously difficult to program.

Although PIM architectures differ in detail, we adopt a simplified abstract model: a PIM device consists of multiple DRAM Processing Units (DPUs), where each DPU contains a processing core tightly coupled with a private memory region. UPMEM \cite{upmem} is one practical realization of this model.

Programming such devices is challenging. To run an application correctly, developers must partition the input data into shards and manually assign each shard to a DPU. In practice, additional complexity arises from hardware limitations. For instance, UPMEM lacks a memory allocator, so programmers must explicitly design and manage the memory layout within each DPU. Moreover, performance is highly sensitive to data placement. If two shards accessed consecutively are mapped to different DPUs, the program incurs cross-DPU communication, which is orders of magnitude slower than local access. Our benchmarks show that in typical applications (e.g., BFS), poor data placement can lead to severe communication overheads.

Unfortunately, manually optimizing data-to-DPU mappings is hard: it is essentially a constrained scheduling problem where the cost depends on the runtime order of data accesses.

We propose JacPIM, a compiler–runtime system that extends the core principle of PIM: data remains resident in memory while computation is moved to the data. In JacPIM, computations are expressed as operations that traverse data structures directly where they are stored, rather than pulling data into a fixed compute unit.
