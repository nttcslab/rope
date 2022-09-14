# ROPE

![](https://img.shields.io/badge/MATLAB-R2020b-green.svg)

![](https://img.shields.io/badge/MATLAB-Image%20Processing%20Toolbox-green.svg)

![](https://img.shields.io/badge/OS-CentOS%207-green.svg)

Code of the paper "[Reflectance-oriented probabilistic equalization for image enhancement](https://ieeexplore.ieee.org/document/9414651)" published in ICASSP 2021.

* In this paper, we proposed a novel 2D histogram equalization approach known as reflectance-oriented probabilistic equalization (ROPE), which allows for adaptive regulation of global brightness.

* Please read `LICENSE.md` for license details.

* The original code was tested using MATLAB2020b on a machine running CentOS 7, but should also work on other OSs.

* Requirements

  * MATLAB
  * Image Processing Toolbox (Required by LIME)

* run `demo.m` for the demo

* `LIME.p` is provided by [Guo et al.](https://sites.google.com/view/xjguo/lime) , which is used as an edge preserving filter for illumination estimation.

* Test images are provided by [USC-SIPI](http://sipi.usc.edu/database/) and by [Guo et al.](https://sites.google.com/view/xjguo/lime)

* Technical questions should be directed to the contact author, Xiaomeng Wu, using the following email address:

  ![qr](qr.png)
