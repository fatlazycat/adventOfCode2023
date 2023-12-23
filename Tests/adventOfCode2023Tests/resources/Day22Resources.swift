
import Foundation

let day22DummyData = """
1,0,1~1,2,1,A,
0,0,2~2,0,2,B,
0,2,3~2,2,3,C,
0,0,4~0,2,4,D,
2,0,5~2,2,5,E,
0,1,6~2,1,6,F,
1,1,8~1,1,9,G,
"""

let day22Data = """
4,4,141~6,4,141
5,2,15~5,3,15
7,9,173~9,9,173
1,0,234~1,1,234
6,8,38~8,8,38
0,9,92~2,9,92
8,7,244~8,7,244
5,2,240~8,2,240
5,1,298~5,3,298
6,4,203~6,7,203
4,4,230~4,6,230
7,7,238~7,9,238
1,7,43~1,9,43
1,2,198~3,2,198
6,7,31~6,9,31
2,5,200~2,8,200
0,3,240~2,3,240
4,6,213~4,8,213
3,4,10~3,4,12
5,9,169~5,9,171
7,5,145~7,7,145
1,5,71~1,5,73
9,1,156~9,2,156
6,4,123~9,4,123
3,4,272~3,6,272
5,5,89~5,8,89
7,6,240~7,6,241
7,5,96~7,5,99
7,5,210~7,7,210
1,2,152~1,2,153
2,9,95~3,9,95
5,0,81~6,0,81
4,0,11~5,0,11
5,2,10~8,2,10
3,3,85~5,3,85
2,4,149~2,6,149
3,2,90~6,2,90
6,0,53~6,0,54
5,0,289~5,2,289
0,3,137~0,5,137
1,5,261~1,6,261
7,3,37~7,4,37
5,7,166~5,8,166
4,4,198~4,6,198
9,2,27~9,6,27
6,4,12~7,4,12
8,9,265~9,9,265
3,1,90~6,1,90
2,4,5~4,4,5
5,0,233~5,4,233
8,2,42~8,2,44
1,5,50~1,7,50
9,1,122~9,3,122
2,1,200~2,3,200
1,2,93~3,2,93
6,9,271~9,9,271
1,5,84~1,5,86
5,8,85~7,8,85
6,8,158~8,8,158
6,1,201~6,3,201
7,7,6~8,7,6
0,3,129~0,6,129
8,0,133~8,2,133
9,2,217~9,3,217
1,1,43~2,1,43
5,9,194~8,9,194
6,7,206~9,7,206
4,6,278~5,6,278
4,5,281~6,5,281
3,3,49~3,5,49
2,4,58~2,7,58
1,0,74~1,2,74
4,3,195~4,5,195
4,7,44~4,7,46
9,5,74~9,7,74
2,6,70~4,6,70
0,5,2~0,7,2
0,3,10~0,5,10
8,4,208~8,5,208
6,8,195~6,8,197
0,1,232~1,1,232
1,6,105~4,6,105
0,2,2~0,4,2
6,1,222~6,3,222
2,3,250~3,3,250
5,5,31~5,6,31
9,6,213~9,7,213
4,3,80~4,5,80
0,9,136~0,9,138
1,4,145~3,4,145
4,6,158~4,8,158
3,4,251~3,6,251
1,2,29~4,2,29
4,7,81~4,7,81
7,7,34~7,9,34
0,0,193~1,0,193
7,0,126~7,2,126
9,4,77~9,5,77
3,0,227~3,1,227
4,5,14~4,5,15
1,5,120~1,8,120
8,0,57~8,0,57
2,6,248~3,6,248
2,6,209~4,6,209
4,2,65~6,2,65
6,4,300~7,4,300
3,2,130~5,2,130
2,8,181~4,8,181
5,2,18~8,2,18
3,1,195~3,4,195
0,2,215~0,6,215
2,6,113~2,6,113
5,0,281~5,2,281
2,9,49~5,9,49
0,3,272~2,3,272
5,3,220~5,6,220
0,5,223~0,8,223
6,7,190~6,9,190
3,8,24~5,8,24
3,5,245~3,8,245
3,9,163~6,9,163
2,0,276~2,2,276
0,3,242~2,3,242
0,6,43~0,8,43
8,4,258~8,6,258
6,8,172~8,8,172
6,6,185~6,9,185
3,4,197~4,4,197
0,8,204~3,8,204
4,8,110~6,8,110
4,2,292~7,2,292
9,0,201~9,1,201
5,3,18~5,3,21
5,7,9~6,7,9
7,6,3~9,6,3
0,1,9~3,1,9
0,6,229~0,9,229
3,2,248~3,3,248
0,4,189~0,5,189
4,2,138~4,2,139
4,9,216~6,9,216
6,2,51~6,5,51
3,7,3~3,7,5
6,4,183~6,6,183
3,4,211~3,5,211
0,9,164~3,9,164
7,2,183~7,2,185
9,1,49~9,3,49
7,1,101~7,4,101
6,2,146~7,2,146
8,4,83~8,6,83
1,4,83~1,7,83
5,3,296~7,3,296
3,2,262~6,2,262
5,5,2~5,6,2
4,5,124~4,7,124
7,5,56~7,5,57
4,2,198~6,2,198
9,5,151~9,8,151
5,1,18~6,1,18
0,3,130~0,3,133
1,3,290~3,3,290
5,0,129~5,3,129
6,8,263~8,8,263
2,0,66~2,0,66
9,2,219~9,4,219
8,1,41~8,3,41
4,8,219~6,8,219
0,3,139~0,6,139
8,3,266~8,6,266
7,0,52~8,0,52
0,5,121~3,5,121
7,6,91~7,8,91
2,5,66~2,7,66
4,3,138~7,3,138
1,6,139~4,6,139
6,1,294~6,4,294
0,6,218~0,6,219
6,0,48~6,3,48
1,3,238~1,6,238
7,5,149~9,5,149
6,0,200~6,2,200
2,7,19~2,9,19
3,3,238~3,3,240
5,7,178~5,9,178
5,4,180~5,4,180
6,6,109~8,6,109
4,5,183~4,7,183
3,0,4~3,1,4
6,9,174~7,9,174
5,6,215~7,6,215
4,7,253~4,7,255
1,4,3~1,4,5
0,7,209~2,7,209
2,4,183~4,4,183
3,8,227~3,9,227
8,9,175~8,9,175
3,2,118~5,2,118
7,1,245~9,1,245
1,1,111~2,1,111
2,1,274~6,1,274
6,7,161~6,9,161
4,1,275~7,1,275
8,6,178~8,8,178
5,8,278~8,8,278
9,5,3~9,5,5
8,1,280~9,1,280
0,0,42~0,2,42
7,1,72~7,4,72
0,4,37~0,6,37
3,7,57~3,8,57
9,5,94~9,5,94
1,0,190~3,0,190
0,2,76~1,2,76
4,1,131~4,3,131
6,0,178~9,0,178
3,4,81~3,5,81
8,2,287~9,2,287
8,7,218~8,9,218
5,1,244~5,3,244
7,4,270~7,5,270
1,0,54~4,0,54
8,2,259~9,2,259
7,5,147~7,7,147
8,6,11~9,6,11
2,9,79~4,9,79
4,4,118~4,6,118
6,8,166~9,8,166
7,8,93~9,8,93
0,3,42~1,3,42
3,8,248~3,8,251
9,2,257~9,5,257
8,1,291~8,3,291
5,0,50~7,0,50
2,1,17~2,4,17
1,4,63~3,4,63
9,5,14~9,7,14
2,0,77~4,0,77
5,4,98~5,4,98
4,8,275~7,8,275
9,6,12~9,8,12
3,2,92~4,2,92
4,5,7~4,6,7
6,5,238~8,5,238
4,9,195~6,9,195
2,4,31~2,6,31
2,3,87~3,3,87
0,7,198~0,7,201
5,4,278~8,4,278
1,2,202~1,2,205
3,3,192~6,3,192
2,2,266~5,2,266
6,1,44~8,1,44
4,3,35~5,3,35
1,9,125~3,9,125
5,6,23~5,8,23
6,3,242~8,3,242
6,6,277~9,6,277
8,4,201~8,4,205
0,6,179~0,9,179
1,3,269~1,5,269
7,9,191~8,9,191
0,9,23~3,9,23
5,6,269~5,8,269
6,1,50~6,3,50
5,4,57~5,5,57
2,7,47~2,8,47
6,0,258~8,0,258
5,2,132~5,4,132
1,6,5~1,8,5
2,0,74~5,0,74
3,7,65~5,7,65
4,5,274~4,6,274
8,1,96~8,3,96
2,5,1~2,6,1
5,5,124~5,7,124
3,3,163~5,3,163
2,8,216~4,8,216
7,3,154~9,3,154
2,1,69~4,1,69
3,6,8~3,9,8
4,5,76~4,8,76
0,0,196~0,0,196
2,8,62~4,8,62
3,4,249~6,4,249
7,6,33~7,9,33
4,5,194~4,7,194
1,6,246~3,6,246
2,4,32~5,4,32
7,3,211~7,5,211
0,8,134~2,8,134
4,6,21~6,6,21
6,6,193~6,8,193
6,2,247~9,2,247
3,9,270~5,9,270
1,3,165~3,3,165
2,7,11~4,7,11
7,5,82~7,7,82
2,6,88~5,6,88
4,0,78~7,0,78
6,7,3~6,8,3
1,7,179~1,9,179
2,6,174~2,8,174
9,4,81~9,6,81
3,3,198~5,3,198
2,0,189~2,1,189
3,1,224~3,3,224
6,8,62~7,8,62
7,6,29~9,6,29
4,1,236~7,1,236
9,0,2~9,2,2
2,0,37~2,2,37
2,8,50~4,8,50
4,5,95~4,7,95
8,0,173~8,1,173
6,1,276~6,2,276
7,0,241~7,1,241
5,1,206~7,1,206
0,0,194~2,0,194
1,1,191~2,1,191
7,4,141~7,5,141
0,9,181~1,9,181
3,2,37~3,5,37
9,0,68~9,2,68
4,7,271~7,7,271
5,5,171~8,5,171
2,2,225~3,2,225
7,2,256~7,4,256
2,8,152~4,8,152
0,4,188~2,4,188
8,4,94~8,6,94
4,1,93~5,1,93
2,2,272~3,2,272
7,0,295~7,2,295
2,8,163~3,8,163
9,7,76~9,7,76
4,6,40~4,9,40
4,5,75~4,6,75
3,9,51~6,9,51
6,2,59~9,2,59
7,3,214~7,5,214
8,4,40~8,7,40
9,1,70~9,3,70
8,1,217~9,1,217
4,8,163~6,8,163
4,4,201~5,4,201
1,8,66~1,9,66
5,1,52~6,1,52
6,3,36~7,3,36
2,2,186~2,4,186
2,4,90~5,4,90
4,3,62~7,3,62
0,7,71~2,7,71
0,5,277~2,5,277
2,9,133~4,9,133
3,7,278~3,8,278
0,2,151~1,2,151
7,2,281~9,2,281
5,4,174~5,6,174
7,5,4~7,6,4
0,6,261~0,8,261
3,3,76~3,5,76
2,4,232~2,7,232
2,2,204~2,2,206
9,6,83~9,6,86
8,0,3~9,0,3
5,3,131~7,3,131
5,6,177~8,6,177
4,8,20~5,8,20
0,9,132~2,9,132
1,0,57~2,0,57
1,4,131~1,6,131
2,1,46~2,2,46
7,0,255~7,2,255
4,8,209~4,9,209
2,0,79~2,2,79
0,3,256~0,6,256
5,0,291~5,0,293
4,2,267~5,2,267
2,1,114~2,1,116
1,1,40~4,1,40
7,5,267~7,6,267
4,6,182~6,6,182
2,8,15~4,8,15
6,5,158~8,5,158
6,4,267~6,6,267
0,3,273~4,3,273
2,0,32~2,2,32
0,3,70~0,3,71
4,2,263~4,3,263
2,3,113~2,3,115
7,4,89~7,4,89
2,6,130~4,6,130
8,1,4~9,1,4
8,3,50~8,5,50
2,5,71~5,5,71
3,9,48~5,9,48
0,6,106~0,8,106
6,4,140~6,6,140
5,6,82~5,9,82
9,8,14~9,9,14
2,5,176~4,5,176
8,2,74~8,5,74
1,7,270~2,7,270
5,7,90~6,7,90
1,4,209~2,4,209
5,3,184~7,3,184
3,5,191~6,5,191
1,7,22~3,7,22
9,7,211~9,9,211
7,4,237~7,7,237
2,7,55~3,7,55
2,4,140~2,6,140
7,3,148~7,5,148
5,5,154~7,5,154
1,5,239~4,5,239
2,3,2~4,3,2
2,1,97~5,1,97
4,3,234~4,6,234
5,4,223~5,4,225
5,6,26~5,7,26
0,4,81~1,4,81
8,5,145~8,8,145
4,5,251~4,7,251
0,2,85~0,3,85
2,2,80~2,2,83
4,0,32~4,3,32
3,1,269~3,2,269
6,7,34~6,9,34
5,3,302~7,3,302
8,1,244~9,1,244
4,3,267~4,5,267
5,0,13~5,1,13
3,7,265~3,7,267
7,8,154~9,8,154
5,5,289~7,5,289
0,1,234~0,2,234
6,9,88~9,9,88
3,0,3~3,1,3
9,4,72~9,6,72
1,3,13~2,3,13
1,8,202~2,8,202
2,7,14~2,8,14
8,8,34~8,8,37
5,9,222~5,9,222
8,3,127~9,3,127
6,5,162~6,7,162
4,5,150~7,5,150
1,9,235~2,9,235
6,1,221~7,1,221
4,7,156~4,7,157
6,8,37~7,8,37
4,7,78~4,9,78
0,3,68~0,5,68
0,7,5~0,7,7
1,7,198~4,7,198
0,9,135~2,9,135
2,6,85~5,6,85
5,0,247~5,1,247
3,7,167~5,7,167
9,0,9~9,0,11
0,4,66~0,6,66
9,2,30~9,4,30
8,5,174~8,5,177
3,7,60~4,7,60
0,4,70~2,4,70
6,7,65~9,7,65
5,7,5~8,7,5
4,3,211~4,6,211
0,7,1~0,9,1
2,8,69~3,8,69
0,6,249~1,6,249
6,9,188~8,9,188
0,9,24~0,9,27
4,6,212~6,6,212
2,4,1~2,4,3
3,4,47~3,6,47
4,7,21~4,9,21
1,2,134~4,2,134
0,6,210~3,6,210
3,1,133~5,1,133
3,5,178~3,7,178
3,3,121~6,3,121
2,5,128~2,7,128
9,4,141~9,6,141
5,2,116~5,4,116
9,4,16~9,4,18
6,3,168~6,5,168
4,5,147~4,7,147
0,6,124~1,6,124
1,0,155~1,2,155
5,5,251~5,5,254
9,1,85~9,4,85
9,0,71~9,0,74
3,7,195~4,7,195
2,7,6~4,7,6
2,1,16~2,3,16
1,2,60~3,2,60
1,1,51~2,1,51
0,0,81~2,0,81
1,0,208~1,2,208
1,3,271~1,4,271
4,7,28~7,7,28
5,9,263~5,9,264
4,3,269~4,3,269
0,7,210~2,7,210
5,4,44~5,5,44
3,9,85~5,9,85
7,4,90~7,6,90
7,0,7~9,0,7
6,1,62~8,1,62
5,6,276~5,7,276
4,1,218~7,1,218
8,6,21~9,6,21
3,5,136~3,8,136
6,6,231~6,9,231
3,8,17~5,8,17
6,3,71~8,3,71
6,1,279~8,1,279
3,8,67~5,8,67
6,1,189~8,1,189
6,1,167~6,4,167
6,2,13~8,2,13
9,5,268~9,8,268
8,7,85~8,9,85
4,6,235~7,6,235
6,7,163~6,7,166
1,7,204~1,7,207
6,3,266~6,5,266
6,3,256~6,6,256
3,7,61~3,9,61
0,6,46~0,8,46
8,6,271~9,6,271
0,8,168~0,8,169
7,6,209~7,7,209
3,9,22~5,9,22
0,8,90~3,8,90
4,7,268~4,9,268
5,3,23~8,3,23
5,1,1~5,1,3
6,6,30~8,6,30
1,6,71~3,6,71
7,4,28~9,4,28
7,3,275~7,6,275
6,7,33~6,9,33
6,5,265~8,5,265
1,4,172~1,6,172
5,2,239~7,2,239
6,2,251~6,4,251
4,5,241~4,8,241
7,7,262~9,7,262
3,4,281~6,4,281
1,3,174~1,5,174
4,4,13~4,7,13
6,9,269~7,9,269
4,6,28~6,6,28
6,9,56~7,9,56
7,7,149~9,7,149
0,1,228~3,1,228
4,7,83~7,7,83
1,7,68~4,7,68
1,4,78~3,4,78
1,1,72~2,1,72
6,5,196~9,5,196
4,4,92~4,7,92
5,7,56~5,9,56
4,2,96~4,5,96
1,7,127~1,9,127
4,0,212~7,0,212
9,1,66~9,3,66
0,7,28~0,9,28
5,1,123~5,3,123
2,2,41~2,5,41
4,9,84~7,9,84
4,1,31~4,3,31
1,7,113~1,7,115
2,7,167~2,9,167
5,3,300~7,3,300
5,8,60~9,8,60
0,7,29~0,7,31
7,9,267~8,9,267
3,0,56~5,0,56
5,3,89~7,3,89
5,5,38~5,8,38
3,2,203~5,2,203
1,2,190~1,4,190
7,4,241~9,4,241
1,2,264~1,5,264
8,8,13~9,8,13
6,4,297~7,4,297
1,0,50~2,0,50
0,6,100~0,9,100
4,1,42~4,1,44
5,3,260~7,3,260
4,4,268~4,4,269
4,1,83~4,4,83
6,2,176~6,6,176
9,4,290~9,7,290
7,0,75~7,1,75
6,2,93~8,2,93
6,6,255~8,6,255
1,6,91~3,6,91
7,7,211~7,9,211
2,2,286~2,2,287
1,2,180~1,2,181
6,1,259~6,4,259
7,5,281~8,5,281
8,3,117~9,3,117
2,3,230~5,3,230
0,7,197~3,7,197
1,3,291~1,5,291
7,4,17~7,7,17
4,5,146~6,5,146
4,0,51~4,2,51
6,8,66~7,8,66
3,2,287~5,2,287
1,2,44~1,3,44
4,6,108~4,8,108
5,1,179~8,1,179
9,0,212~9,3,212
1,6,203~1,9,203
1,0,237~1,2,237
6,1,104~6,3,104
3,3,222~4,3,222
6,0,177~6,2,177
3,8,2~6,8,2
5,2,213~7,2,213
4,0,237~4,1,237
9,5,8~9,5,10
9,3,69~9,6,69
8,1,31~8,1,33
6,2,7~8,2,7
4,4,143~6,4,143
1,6,169~4,6,169
9,0,123~9,1,123
9,1,258~9,4,258
2,7,131~2,9,131
5,4,151~5,7,151
3,7,128~3,9,128
0,0,14~0,2,14
0,4,233~2,4,233
5,1,74~5,1,75
7,0,104~7,1,104
4,1,183~5,1,183
5,2,64~6,2,64
2,5,72~2,5,73
2,1,7~3,1,7
3,4,52~3,4,54
8,3,240~8,5,240
4,1,260~8,1,260
7,3,156~7,3,159
7,7,201~8,7,201
1,4,207~1,5,207
2,1,184~2,1,186
1,2,106~4,2,106
0,6,12~0,8,12
6,4,17~6,5,17
8,2,134~8,2,134
5,4,152~5,4,153
7,0,282~7,1,282
3,9,134~5,9,134
6,1,173~6,3,173
1,3,92~2,3,92
5,7,288~6,7,288
8,1,130~8,1,132
2,1,289~2,4,289
7,4,156~7,5,156
6,1,282~6,3,282
6,3,164~8,3,164
8,7,84~8,9,84
7,4,149~7,4,151
2,6,35~3,6,35
9,3,220~9,5,220
1,4,216~1,6,216
7,4,264~7,4,266
4,8,175~6,8,175
5,2,195~5,4,195
1,6,16~4,6,16
5,8,64~7,8,64
0,8,206~2,8,206
0,1,193~0,1,193
3,9,229~5,9,229
5,2,232~5,3,232
7,5,93~9,5,93
6,9,93~8,9,93
7,5,173~7,6,173
8,2,249~8,2,251
0,4,290~2,4,290
4,2,278~7,2,278
0,0,84~2,0,84
3,5,271~3,7,271
1,1,148~1,4,148
4,4,154~5,4,154
8,3,8~8,4,8
6,3,66~6,3,69
4,9,8~6,9,8
1,2,182~1,4,182
4,2,14~7,2,14
5,2,33~5,4,33
0,6,221~3,6,221
5,2,93~5,4,93
8,5,241~8,7,241
8,4,198~8,7,198
9,5,198~9,6,198
5,0,209~5,2,209
2,2,228~4,2,228
0,6,23~1,6,23
6,4,88~6,7,88
9,3,197~9,5,197
8,1,36~8,3,36
7,5,79~9,5,79
1,9,136~1,9,139
3,3,228~5,3,228
2,3,61~2,4,61
8,8,219~9,8,219
0,4,34~2,4,34
5,1,216~8,1,216
2,0,203~4,0,203
2,5,269~5,5,269
3,5,258~3,7,258
3,6,159~5,6,159
5,5,54~5,6,54
4,2,9~4,4,9
6,1,256~7,1,256
2,7,26~2,9,26
0,8,166~0,9,166
2,6,61~3,6,61
4,5,82~4,8,82
7,4,215~7,4,215
2,6,89~2,9,89
2,5,18~2,6,18
9,3,276~9,6,276
6,3,268~6,5,268
4,1,49~4,3,49
2,1,49~2,1,50
7,7,281~9,7,281
3,9,219~6,9,219
2,2,284~5,2,284
1,9,82~4,9,82
1,4,215~1,5,215
9,0,198~9,3,198
3,5,217~3,6,217
0,2,86~0,4,86
8,0,107~8,1,107
2,0,195~2,0,197
3,0,250~3,0,250
0,3,253~2,3,253
3,0,121~5,0,121
5,1,87~5,3,87
5,6,41~6,6,41
9,1,256~9,4,256
2,5,4~4,5,4
9,5,273~9,6,273
5,3,187~5,3,190
4,7,165~4,9,165
3,8,205~3,9,205
2,8,236~2,9,236
6,7,286~7,7,286
7,1,243~9,1,243
8,4,152~8,6,152
1,5,255~3,5,255
2,6,68~4,6,68
3,5,174~3,8,174
3,3,265~5,3,265
5,7,284~7,7,284
2,4,143~2,6,143
9,1,84~9,4,84
9,3,13~9,5,13
4,1,77~4,4,77
8,0,16~8,2,16
1,6,65~1,6,66
7,2,144~7,4,144
5,4,113~8,4,113
0,5,11~0,7,11
5,7,260~5,9,260
8,3,178~8,5,178
1,5,5~2,5,5
5,1,59~6,1,59
8,6,157~8,9,157
6,1,213~9,1,213
1,6,77~1,7,77
0,9,251~1,9,251
3,6,53~3,8,53
0,1,54~0,1,56
0,1,28~3,1,28
6,6,18~8,6,18
2,9,284~5,9,284
1,0,266~1,2,266
6,5,279~9,5,279
5,7,279~9,7,279
0,4,236~0,4,238
4,6,186~4,9,186
9,2,120~9,5,120
0,0,130~0,2,130
1,3,79~3,3,79
3,7,77~3,7,79
0,6,97~2,6,97
5,0,16~7,0,16
0,1,135~0,3,135
5,4,260~5,4,261
3,3,98~4,3,98
3,3,185~3,4,185
5,8,9~6,8,9
0,0,48~0,0,50
4,4,1~4,4,3
6,4,14~6,6,14
0,2,127~0,5,127
6,1,171~8,1,171
5,0,182~5,2,182
5,8,90~5,8,92
2,5,51~2,6,51
6,9,232~6,9,235
6,1,45~9,1,45
9,2,214~9,4,214
6,8,96~6,9,96
1,4,150~3,4,150
6,1,3~6,3,3
8,3,151~8,6,151
5,4,175~5,4,178
7,2,253~7,2,253
2,4,88~4,4,88
1,5,274~3,5,274
3,1,51~3,3,51
2,3,91~2,5,91
9,0,265~9,0,267
8,5,95~8,6,95
3,4,115~5,4,115
5,0,120~5,3,120
9,2,155~9,5,155
2,2,201~2,5,201
5,2,79~8,2,79
1,6,122~1,9,122
6,4,107~6,6,107
5,4,259~5,6,259
3,0,248~5,0,248
7,3,263~7,6,263
7,4,36~7,6,36
8,1,127~8,1,128
7,4,271~7,4,273
1,7,110~3,7,110
4,1,283~6,1,283
4,6,128~6,6,128
6,4,179~6,6,179
6,6,142~8,6,142
2,8,221~4,8,221
3,9,283~5,9,283
0,1,78~0,2,78
8,5,73~9,5,73
9,2,97~9,5,97
6,5,145~6,6,145
1,0,177~1,3,177
8,6,256~8,6,257
0,4,126~0,6,126
5,6,261~5,7,261
7,8,266~9,8,266
4,0,201~4,2,201
5,4,147~5,7,147
3,6,119~4,6,119
5,5,257~5,8,257
6,7,113~7,7,113
6,1,257~6,3,257
2,6,133~2,7,133
4,6,42~4,9,42
2,8,43~5,8,43
0,4,8~1,4,8
1,4,15~3,4,15
5,5,53~7,5,53
5,4,84~8,4,84
6,7,274~8,7,274
4,3,171~7,3,171
6,4,206~6,5,206
7,5,7~7,8,7
8,7,8~9,7,8
7,5,18~8,5,18
1,8,219~2,8,219
8,2,284~8,4,284
0,6,259~0,7,259
0,0,229~0,1,229
9,5,158~9,6,158
7,4,230~7,6,230
6,2,243~6,2,244
7,1,20~7,2,20
5,6,201~6,6,201
6,0,4~9,0,4
1,2,77~1,2,77
2,7,274~3,7,274
2,6,30~4,6,30
3,6,142~3,8,142
6,3,77~8,3,77
7,4,136~7,6,136
4,7,150~4,8,150
1,7,46~1,9,46
1,1,34~3,1,34
1,0,83~2,0,83
0,9,287~3,9,287
3,4,56~3,6,56
7,9,192~8,9,192
2,2,10~2,4,10
1,7,75~3,7,75
8,5,290~8,7,290
3,8,58~3,8,59
6,5,138~9,5,138
3,4,34~3,7,34
5,7,62~7,7,62
3,4,42~5,4,42
1,2,199~1,3,199
0,7,281~2,7,281
7,4,41~9,4,41
8,6,31~8,8,31
6,9,213~8,9,213
3,2,301~5,2,301
8,2,209~9,2,209
0,8,47~0,9,47
1,0,278~3,0,278
1,5,61~3,5,61
9,2,289~9,4,289
7,0,261~9,0,261
5,2,98~5,2,100
0,6,40~1,6,40
7,4,43~9,4,43
7,2,123~9,2,123
8,1,288~8,3,288
5,6,274~5,9,274
9,4,172~9,5,172
3,3,246~5,3,246
6,2,63~9,2,63
8,2,85~8,4,85
7,4,299~8,4,299
6,7,7~6,9,7
0,1,11~0,3,11
4,9,223~5,9,223
7,8,1~9,8,1
4,7,111~6,7,111
6,3,254~9,3,254
1,8,133~3,8,133
3,2,2~3,2,3
5,5,125~7,5,125
4,0,30~4,2,30
3,5,254~3,6,254
7,2,250~7,4,250
5,3,161~8,3,161
1,2,15~1,3,15
3,0,132~5,0,132
0,6,94~2,6,94
5,6,228~8,6,228
6,5,201~8,5,201
0,7,74~0,9,74
0,6,64~2,6,64
0,3,149~0,5,149
6,4,180~7,4,180
4,3,179~6,3,179
2,3,42~2,3,43
4,5,177~4,5,179
3,1,26~3,3,26
1,5,108~1,7,108
2,4,94~2,4,96
5,2,53~6,2,53
7,3,59~7,5,59
5,6,218~5,6,218
1,6,274~1,8,274
2,4,40~3,4,40
8,6,67~8,7,67
5,3,66~5,3,68
5,4,86~7,4,86
5,6,59~5,8,59
2,1,109~2,4,109
2,3,110~2,6,110
0,5,214~3,5,214
4,2,75~7,2,75
3,7,261~3,7,263
3,4,247~5,4,247
3,0,30~3,1,30
1,0,46~1,1,46
9,0,67~9,1,67
4,6,272~6,6,272
8,5,81~8,7,81
3,5,284~3,8,284
4,9,54~6,9,54
4,9,91~6,9,91
5,1,98~6,1,98
2,8,16~2,9,16
0,3,108~1,3,108
6,0,133~6,3,133
0,7,177~3,7,177
1,4,267~1,7,267
4,5,74~7,5,74
2,6,37~5,6,37
7,1,48~9,1,48
7,3,134~7,4,134
6,1,169~7,1,169
8,2,38~8,5,38
0,2,66~2,2,66
6,2,61~9,2,61
6,2,25~6,5,25
1,5,128~1,8,128
1,5,141~1,7,141
4,4,89~4,4,89
9,6,264~9,9,264
2,4,180~2,8,180
8,3,25~9,3,25
7,1,209~7,3,209
3,7,19~3,9,19
8,7,216~8,9,216
4,8,79~6,8,79
8,7,180~8,9,180
6,4,170~9,4,170
2,7,234~2,9,234
0,8,65~2,8,65
6,2,263~6,4,263
8,2,207~8,4,207
8,1,124~8,4,124
8,5,260~8,8,260
0,6,250~0,9,250
2,2,112~2,4,112
3,3,54~5,3,54
3,4,67~3,4,69
0,1,192~0,4,192
6,3,105~6,4,105
2,6,276~2,8,276
7,4,202~7,7,202
4,0,294~4,2,294
1,2,107~1,4,107
1,5,100~1,6,100
9,6,5~9,9,5
5,5,60~7,5,60
0,1,52~1,1,52
7,7,221~9,7,221
3,8,281~3,9,281
8,0,28~8,3,28
6,1,207~6,3,207
1,3,243~2,3,243
4,1,293~4,2,293
3,2,245~4,2,245
0,3,259~0,4,259
5,9,166~8,9,166
3,5,73~3,7,73
7,2,186~7,4,186
2,6,168~2,7,168
3,8,224~6,8,224
3,2,242~5,2,242
7,2,96~7,2,99
4,5,247~6,5,247
8,3,281~8,4,281
7,1,203~7,4,203
5,3,127~5,6,127
3,1,271~3,1,271
4,3,244~4,6,244
8,1,9~8,2,9
5,9,172~7,9,172
2,1,181~5,1,181
5,5,193~6,5,193
1,8,167~1,9,167
3,4,48~3,6,48
1,8,3~4,8,3
5,4,96~5,6,96
6,3,33~6,3,35
1,5,69~3,5,69
4,5,249~6,5,249
4,1,16~7,1,16
6,6,265~8,6,265
7,4,9~8,4,9
0,0,47~1,0,47
6,0,105~8,0,105
5,0,298~7,0,298
0,9,286~2,9,286
8,0,181~8,0,183
6,7,2~9,7,2
0,6,103~3,6,103
6,6,148~6,9,148
6,6,199~8,6,199
2,6,171~4,6,171
5,4,9~6,4,9
0,2,82~0,5,82
8,3,3~9,3,3
2,3,241~2,6,241
1,7,279~3,7,279
3,1,70~5,1,70
8,2,116~8,5,116
1,5,258~1,6,258
2,8,207~5,8,207
4,0,10~4,2,10
4,7,126~6,7,126
4,9,45~7,9,45
6,4,185~6,5,185
3,1,46~5,1,46
3,5,21~3,7,21
6,1,76~6,2,76
3,3,23~3,5,23
8,0,263~9,0,263
1,6,235~3,6,235
4,6,18~5,6,18
9,0,51~9,2,51
3,2,302~3,4,302
6,5,252~6,8,252
1,7,91~1,9,91
6,3,110~6,5,110
4,3,103~7,3,103
5,0,61~5,2,61
2,8,46~2,9,46
8,2,117~8,2,120
4,5,226~4,5,228
5,3,226~5,6,226
6,8,264~8,8,264
8,8,269~9,8,269
5,8,169~6,8,169
3,7,277~3,9,277
0,9,180~1,9,180
7,3,167~7,3,169
2,6,125~4,6,125
4,5,121~6,5,121
2,0,63~2,3,63
4,3,63~6,3,63
4,3,223~4,5,223
6,8,272~8,8,272
7,7,88~8,7,88
6,3,49~6,4,49
3,4,206~3,7,206
3,7,35~3,7,37
1,5,273~1,8,273
5,4,185~5,6,185
6,1,56~6,3,56
0,2,43~2,2,43
3,1,80~3,3,80
0,6,183~2,6,183
8,0,186~8,3,186
5,0,36~5,2,36
8,8,14~8,8,16
0,6,185~1,6,185
7,2,82~8,2,82
6,0,77~6,1,77
3,3,236~5,3,236
1,8,151~4,8,151
6,5,16~7,5,16
5,0,96~5,2,96
4,2,210~6,2,210
2,4,7~6,4,7
1,6,18~1,6,20
5,5,234~5,5,237
7,7,18~9,7,18
4,8,267~6,8,267
0,6,222~0,7,222
3,4,65~3,5,65
4,5,153~4,7,153
8,2,5~8,3,5
6,1,136~6,4,136
1,6,49~3,6,49
5,0,71~5,2,71
1,0,29~1,1,29
7,1,182~7,3,182
2,1,66~3,1,66
0,9,11~3,9,11
9,6,208~9,9,208
3,3,219~3,7,219
5,5,186~5,5,189
9,6,88~9,8,88
3,8,160~5,8,160
6,6,9~9,6,9
7,2,6~9,2,6
6,2,204~8,2,204
5,8,95~5,8,98
2,1,208~2,3,208
2,5,231~5,5,231
0,7,44~0,7,45
6,2,32~6,6,32
4,1,137~4,2,137
0,1,40~0,4,40
0,7,226~1,7,226
3,2,58~3,4,58
4,7,48~6,7,48
0,6,76~0,8,76
3,2,45~3,4,45
1,4,204~1,6,204
8,0,55~8,1,55
1,7,208~1,7,208
2,7,203~5,7,203
3,7,244~5,7,244
7,3,208~8,3,208
8,2,47~8,3,47
5,1,294~5,4,294
1,5,117~1,7,117
7,1,238~7,2,238
6,8,81~8,8,81
1,4,85~3,4,85
9,6,155~9,8,155
5,7,128~6,7,128
7,8,182~9,8,182
0,4,89~0,4,90
9,9,90~9,9,92
2,5,209~3,5,209
2,1,41~4,1,41
0,9,9~3,9,9
2,8,25~4,8,25
5,7,69~5,8,69
6,7,287~8,7,287
1,7,1~2,7,1
4,1,105~4,4,105
5,1,215~7,1,215
0,5,24~0,7,24
7,5,288~7,7,288
1,7,40~3,7,40
8,6,42~9,6,42
0,5,146~3,5,146
7,6,257~7,6,259
2,6,218~3,6,218
8,7,159~8,7,160
"""
