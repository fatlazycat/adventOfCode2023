
import Foundation

let day7DummyData = """
32T3K 765
T55J5 684
KK677 28
KTJJT 220
QQQJA 483
"""

let day7Data = """
94J8A 16
JK59A 722
Q5QQQ 681
T99T2 39
595JQ 533
98299 550
T596T 971
JQ999 831
J3K39 340
K93T5 107
2999T 750
KQ4K4 603
TT6TT 778
QAQJQ 731
K2444 109
T87J4 984
72272 70
555QJ 266
44384 872
67768 140
555A9 322
Q9A52 14
6JTTT 994
66J7Q 360
6J966 170
74335 288
Q7QK7 318
T63K8 355
88Q38 612
TKKKK 291
8T295 608
77A77 312
3ATTA 861
6JJ66 866
82367 229
J86TQ 457
AJAAA 521
JTTTT 380
555K5 223
4Q688 398
84K8Q 302
TQ478 514
A2229 604
69JA4 536
T5555 815
6877T 287
4333J 617
74Q23 688
A5T5J 21
TT884 945
98J32 22
K7JK7 464
55466 484
J8A78 175
4A586 307
326T9 834
J7883 678
J9TJ2 798
49999 366
2KK9J 436
T7A5K 35
K8A23 172
4TA36 445
33T3T 843
8QA86 397
43QQQ 523
72J99 364
JAATT 9
KTTTT 620
92JT9 389
25552 825
23A58 676
TJ4K6 167
T55J8 636
Q75J5 433
47387 121
TTK33 226
K5786 532
Q88AJ 767
T6725 975
76776 108
KQKK5 753
9T699 73
56AJA 89
KTKK9 947
JQQQJ 998
7Q8J7 600
2A42A 605
Q2K74 566
TATAA 134
227K7 712
K5K7Q 139
4844A 233
44AQA 91
AA888 885
872JK 734
32329 764
5KA54 475
28888 62
K9K88 463
A4AAA 565
9JJ49 117
2685Q 210
KT2T2 594
9TK8T 690
625J8 607
AQQQ9 571
56A6A 916
A4AJ7 935
9J68A 967
5T899 479
T5836 853
88443 404
K5K5K 77
66A65 501
3A3J7 127
66K68 336
KQAKA 391
864QQ 153
Q97QQ 224
74T63 52
6T555 981
4444A 543
8J558 111
5656J 810
89484 439
9A7K3 444
3Q443 306
ATAAA 253
7T934 33
K9582 645
66K26 344
9A9AA 535
J8KQ2 695
AA2AA 491
78777 891
AAQ9A 12
AQJ93 490
KKAKK 913
333TJ 643
Q96J6 826
66767 937
88757 769
584Q6 334
TA29T 162
K33K9 506
T5A5A 836
333Q3 152
6T7KA 31
T6834 572
2TTTJ 959
6AA6A 95
Q4A3A 216
QQ3JJ 471
AT4TT 817
49628 400
388A4 144
TJ75T 86
JQ4Q2 250
8T8JQ 835
TJTT8 56
8T4K9 705
A9JTA 81
36646 420
5KKK2 345
QA965 823
J34K4 85
82288 797
829Q5 488
A699J 399
6642J 1000
K9KK6 267
5JA5A 17
K6TJT 884
7A667 869
KQATT 929
88884 468
K495T 141
6573A 827
KK354 979
JTTT5 335
T5398 182
AAJ9A 157
JQ935 897
J999J 251
T6T5T 702
5TAAA 381
TJT22 960
AJQ57 883
99T9J 234
KKKKJ 495
9K99K 961
QQ777 589
337J2 652
9T269 813
22Q8J 165
98659 847
32TT2 542
2273Q 718
39399 455
9KKQ3 856
64T4T 795
777T8 694
22AJ2 274
69966 706
7K533 860
2TQK9 756
T225T 246
2KK8J 664
QJQ6Q 540
5TTT7 625
799K5 740
KKK2K 6
553J3 431
QAQAQ 454
777JT 970
72492 955
7777T 18
3KA94 496
3J3J3 707
7JJ4Q 746
36463 780
7A42K 545
KTAJA 203
45443 761
95A5J 8
58833 438
66Q23 814
466KK 576
2TT2T 113
426KQ 595
72J49 69
QJKQK 757
J5J5K 667
5522Q 132
QTQ9T 494
T2222 450
3242J 717
66766 968
984J8 372
986QK 739
242TT 902
K46KK 659
3TA5J 644
QA92K 901
QQQ59 933
QJ666 504
JQ2Q8 461
94J49 42
78888 850
T64QT 812
QQQ25 918
855AJ 316
88J28 528
78Q46 672
29999 44
9K96K 13
2KAKK 204
QAQAJ 806
AKKKA 79
22KJ2 27
J89Q6 294
T66JT 640
4J4Q9 208
6Q54Q 297
88777 737
J825A 537
K4K44 498
QQQTQ 493
4J749 434
5Q868 324
99437 243
J9829 425
J2222 720
T5372 37
447TT 437
26292 145
86866 361
Q6T32 771
KKKA7 553
774K7 958
2KJ2K 375
8T34K 60
KTK9T 164
36333 547
55Q55 191
8K37A 123
8945J 704
AA75K 71
TTTT3 280
Q2Q4Q 977
J3936 259
55877 725
4424A 409
97799 46
43422 174
33443 269
AAQ3K 873
69699 395
T8942 824
JT993 105
T44T4 319
9863K 190
A9236 953
2K62K 931
A7TKA 559
32323 41
T2T22 422
2QQ2Q 279
QT3QJ 519
6Q4K5 573
3JA93 7
KJ777 275
A7JTQ 930
AA8Q7 531
2QQ6A 219
6JA9A 136
Q2369 530
99998 830
5788K 218
AQQQQ 683
K33K3 879
K83A9 949
K9J99 356
25J22 657
53AJ7 782
99QQQ 412
63969 821
23455 489
2JAA3 3
77TTT 631
6975A 367
44K7Q 520
J3Q3K 310
AA4AJ 660
5A3A6 833
Q7Q7Q 755
9TQ44 424
878A8 515
T8TTT 323
7TKT7 209
KTTJ5 563
2KQQ3 469
2T45J 808
25AA5 293
6K76J 255
2J53T 807
899J9 507
48448 805
JQ272 849
T9999 794
J2282 992
66588 691
3T273 137
T78T3 453
TA2J6 221
J4J77 647
77762 940
6TKT4 551
48478 941
9K49K 295
4T844 516
5524J 460
4KJ2K 788
2J22J 330
Q5JAQ 87
T3338 168
42JT4 235
77333 646
8JTT6 878
48444 315
TT888 429
48774 385
25732 650
AAA96 684
55J55 103
444Q4 196
77J37 342
765T8 747
TKKJT 4
45842 122
9T3KJ 889
458QA 184
JQQQQ 982
5T492 282
25QJ2 228
Q28TA 899
6T34T 286
A4AA9 579
74444 10
K52K2 689
6K663 343
996J6 875
222QQ 245
73JJT 742
4K466 502
59Q99 5
K43JK 300
2922K 900
AAA3A 938
T5TTT 996
Q7797 560
35767 321
89998 964
TAJ78 539
5552T 254
4J848 675
22932 762
66J44 283
6T66K 371
965J6 415
45TK5 48
4AJT2 943
2232J 687
9KTA3 373
TT44T 602
2975A 596
6683J 862
6TJ54 193
TT3QT 582
3TT3J 567
9585J 554
8A5T8 72
Q8888 124
Q84JK 272
8K882 115
454T3 449
46886 239
63633 692
Q2KQK 622
662AA 714
TQTJ8 858
39699 829
TKT8K 379
8JKTT 854
99Q9Q 264
K52J2 828
QQ223 632
833QT 188
74778 393
3J33A 347
JQAAA 575
4975T 189
AA8AA 98
88588 474
KKKJ5 58
77757 249
6J666 2
88Q8Q 895
KT4T3 924
7A757 20
852A5 838
92479 818
45J55 556
777J7 443
622TT 907
A55J4 236
J94T7 194
TK239 887
T2359 892
3T67K 730
9595Q 480
362J2 912
J33K5 915
999TQ 735
6J555 383
35555 261
7J374 403
77776 200
46226 908
A5A55 627
6466K 999
33433 789
4QQJQ 635
K857T 326
46844 611
55K4J 247
9TTTT 411
K5999 270
3333J 598
9TT9T 615
TKT88 653
7AQJK 629
7A294 863
9JQ4J 427
K7K7K 738
55338 304
55659 120
AA22Q 768
KKK88 886
K7K4A 983
9T449 715
6AA55 956
66556 777
Q4K36 736
78Q77 207
8J778 917
4AJQT 435
9KJQQ 716
422JK 406
62A9J 205
25A25 11
K8888 985
KTTKK 19
76KQT 877
5A555 217
97933 995
4K4KT 135
QQ4J4 546
TATA6 946
KAJ2A 837
8333J 238
47666 376
Q5QA5 839
8Q64T 951
QA23Q 240
T6T7T 972
648T7 92
6T33T 271
25528 948
JAAJA 50
45455 578
AA8J4 588
A6QT2 867
2T392 765
32Q3Q 950
KA8KT 816
59J28 973
883A2 237
J555J 864
62222 325
Q543T 637
338TJ 290
T58J6 198
5QAJ8 583
T4K6Q 476
K3333 888
24443 421
29629 776
J88J7 116
66K33 119
JA7A7 214
J3353 920
45442 616
7Q36T 963
A22JK 719
QAJA6 791
55J44 65
3TQ79 351
8JKK8 642
79999 292
974JK 94
JJJJ8 151
K7JA5 903
JKK4J 932
66755 405
AJ647 146
Q2T29 202
JA6A2 591
55635 374
J6J53 896
75575 621
TTQTJ 852
74Q33 989
9357J 555
T75J5 801
J6KT5 974
T6667 910
3KA6A 597
3TTT3 505
Q2442 423
977Q3 624
28622 442
33338 670
K3KK3 677
7Q995 296
747J4 88
8KKKA 128
6AQJ5 130
7K362 171
4KT35 353
A94A9 561
TT7JQ 388
886A8 441
899Q5 15
AKAAA 529
J6T9T 447
5TQ29 811
TTTAQ 685
56556 359
JKK38 698
75QQJ 440
9TK8J 786
6Q442 54
5KK75 320
47QTQ 623
Q496Q 257
97TTJ 260
A96K2 61
959A5 783
5T55K 256
JJJJ9 570
724T2 197
A4JA2 574
22J29 201
929J3 759
888T6 585
662JK 212
KQ53K 954
99J99 472
424J2 587
566KJ 149
K693T 609
44794 751
7A3TQ 728
5J2J8 666
AAK99 365
KQ378 481
57Q29 865
797AA 842
AAA33 180
5AK55 820
KK5AK 299
77773 378
8K899 944
44994 976
A6AJ6 96
53533 354
45JK4 154
99399 176
22424 518
7AAKK 377
J4KA5 772
Q3QQ8 179
585T5 881
59969 928
2K2K3 710
ATKTA 499
56466 34
44242 308
7J275 741
588T6 317
QKA79 369
JA546 1
4T447 927
A33A3 641
T7T77 301
36366 185
399A7 51
AJ33J 743
T7J7T 59
6KJ7J 426
5J586 32
K8KKK 654
K62K9 341
824K7 133
6AJAA 29
63AJA 993
4K44T 401
67A92 697
A5592 845
AK578 30
QT4TQ 894
3373J 456
35TT3 500
45A48 803
44454 222
54445 628
A6696 527
88AA7 211
344AA 68
6J3TK 248
7557J 701
45T98 394
49TTT 868
448J4 93
A45TQ 682
2A2AA 599
77Q77 78
88585 339
J3QQ3 726
74JK7 980
9454T 327
TTT7T 534
TJK95 370
T2T79 314
2A333 822
J9765 562
9T6T9 36
J2J35 313
789QQ 396
KJ3Q4 362
J5999 166
TQKT3 90
J6T53 413
99655 186
J455T 305
K95A5 601
37377 749
JTKAT 252
J8275 508
QK296 766
AJKK6 610
TTAAT 926
T5T4T 939
QQ8Q8 195
28J2J 593
KKK9K 703
5T5TT 905
88988 101
697JJ 538
6266T 510
2878T 333
T8J26 773
83773 763
T9J33 384
2AK92 656
22JJ3 169
K2T9T 649
QQ8QQ 428
QKJKK 770
T64A5 410
6T7T2 748
T3J55 890
55557 74
AAJ7A 467
22K22 155
TK27J 988
9T64A 309
77AAA 804
QQQ7Q 503
78837 138
6A785 792
6Q4QQ 76
8AT69 721
TKKKJ 680
73555 407
4Q999 114
45K55 242
J4742 390
AA8A8 626
47T3T 898
TA9J8 231
9T9A9 809
4K799 619
8K99K 727
J7KJK 338
AQ4K9 485
QQ2QQ 129
7T45A 473
2T7T2 785
7J749 84
AJ7Q7 733
386AJ 911
59A68 104
335K6 723
KK979 289
898QA 466
9TTKT 648
66933 512
Q7A77 686
24QQT 564
2J2T4 150
JK4K4 386
AAJAK 544
727TJ 526
QJT2T 183
96A6T 244
979T9 876
2239Q 465
8K69J 613
57J54 258
J843J 760
JK333 99
K2K8T 477
T9983 75
A222A 298
22523 800
9999K 840
Q2KA8 511
TTATT 368
83584 793
66966 787
79949 158
73722 711
A36T6 987
Q976J 541
Q4J78 311
AQJJ3 225
888J6 893
QJT44 922
JAJKA 263
5QQ7Q 962
27277 581
JKKJK 358
88877 923
4K3T4 45
A8495 577
A89J5 446
6A355 952
8AA8J 633
32KJ2 163
48282 497
44JJ4 874
KJ93A 674
24444 848
888J8 118
99JA8 181
58J57 66
QKQKQ 143
99JQK 125
84KJ7 178
J95KK 241
6666T 284
K9555 106
7KQKK 513
5Q4QQ 213
88KK8 665
7272J 100
97Q34 492
8569K 262
222KK 925
23J4A 55
9868A 331
2222Q 758
2J553 754
7727A 25
K3QKQ 673
9J292 796
45K44 363
888JK 639
8K43A 851
AQ6J2 517
K4K4K 352
2K224 802
2T44A 934
595J5 63
5Q6QQ 126
QA59J 432
5A55J 357
J738A 80
K666K 278
9QQ6A 978
93242 614
7KK77 661
JA9KK 855
33T53 634
6T2AK 882
2K64T 586
5AT68 584
Q36A7 846
22228 382
444J4 402
27AA7 24
KKAJA 230
8JA5T 663
A2828 131
7AAAQ 914
3345K 997
275TQ 606
9KJ58 569
JTTT7 416
993J9 408
84J55 28
KTKK2 784
98K24 206
J5KJK 841
33944 651
6K7KA 392
T2T92 346
33323 187
JQT59 729
TT2TT 590
2A67K 790
QKAQJ 159
T3TQJ 303
QQ227 478
J2852 708
83834 458
67Q6T 524
26262 552
T4J45 452
2Q5T6 966
QKKT6 160
KQK9Q 273
8Q333 192
4656A 557
64444 83
59434 781
357KK 558
T4QJJ 655
3625T 142
29992 752
A7AAA 220
24KKK 448
J89Q8 40
9569A 328
K7TK7 921
5T777 859
7474T 699
39A7J 49
9QTJQ 880
Q844Q 819
JJKKJ 112
8Q88J 177
K3T89 779
Q365Q 277
8488A 522
J3A3K 199
5AAA5 147
96586 568
88Q48 709
Q85Q8 414
37QAQ 102
K33K2 281
7676J 387
26666 348
AA868 744
9K9TT 658
22233 942
6Q6K8 745
A4AA7 459
66J76 110
J282T 173
23A24 732
KK7K2 580
43344 509
54Q8T 906
96967 57
525J8 417
628Q7 919
2775T 487
A5T67 337
7T887 662
K944K 470
289AJ 592
A6AAA 97
52Q49 482
7AK7J 904
688JJ 462
6Q335 724
23342 47
5KKKK 276
62665 548
4KJ63 67
TTA6Q 332
AQ5AQ 156
J33JJ 232
J88J8 483
JT5A9 936
62ATA 549
J6T33 486
6Q46Q 679
27J2T 693
2A9QT 775
KJ524 638
93JQ2 969
7JJ77 991
55552 53
88868 148
3TJT4 349
7QJ77 990
77797 957
JJ464 350
J68K8 82
2522A 451
49AA4 329
AAQQA 23
J4K44 870
57J55 700
3AA64 832
746JK 525
25522 986
TK333 38
Q44QQ 268
Q3KA3 857
55T57 844
9K57Q 430
KKAA8 671
6J546 669
9K779 909
588J8 630
26266 668
J6999 26
AATAQ 227
7994T 871
47466 419
A4929 713
QKKKK 618
T9Q83 265
55595 799
JJJJJ 64
29A84 696
5AAAA 285
5T6KQ 215
42447 161
33337 418
JJTTT 774
88388 965
22J75 43
"""
