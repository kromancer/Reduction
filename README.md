Reduction
=========

An autotunning CUDA implementation of the reduction pattern, meant for the [ForSyDe f2cc](https://forsyde.ict.kth.se/trac/wiki/ForSyDe/f2cc) backend.
I based my approach on [Professional CUDA C Programming 1st Edition](https://www.amazon.com/Professional-CUDA-Programming-John-Cheng/dp/1118739329/ref=pd_bxgy_14_img_2/163-0340861-1801263?ie=UTF8&psc=1&refRID=51JY2YVCC8W0Y0PQWNE7)

You need to have:
  * R 
  * CUDA > v5.0
  * alex package in Haskell

To run:
  * make build_parsers and then run the autotunner.sh scirpt
  * make clear to reinstate the project 
