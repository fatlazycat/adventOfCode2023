
import Foundation

let day21DummyData = """
...........
.....###.#.
.###.##..#.
..#.#...#..
....#.#....
.##..S####.
.##..#...#.
.......##..
.##.#.####.
.##..##.##.
...........
"""

let day21Data = """
...................................................................................................................................
.....#...........#.............#......##.#.#......#....................#.......#.....#.#....#.....#.#...#......##......#...........
.................#.#...........#.............#...#........#.....................#..........#.........##...#...........##...........
..#..............#..#.#.###..###............#.......#....#.................#...........#......#.........##........#....##........#.
..#...#..#.#...#...#...............#....#.#...#.#...............................#.#....#.............#.........#....#.........#....
..........##....#.....#......#...............#.....#..#.....................#.......#..#.......#.........#..#...#...............##.
.#........##....#....#..#....##.....#..#......#............................#.##....#.....................####.#....#......#....#...
........#...#....#.###.#.....###..#........#..................................................#..#.......#.#......##..##......#....
..#..#...#...#.#...#.#...#.#.....................#...................#......................#.#.##................#.#............#.
..#.#........#..##......#..#......#..#....#..................#.......................#...#.......#..#............#.##.#.#.....#....
.#....#.#.#.......#..........#.....#....#.........#.........#.##....................................#...........#...#.#..#.##..#...
...............................#..#........###.##...........#.....#..#.#.........#.....................#........#......##.....#....
.............#..#........##...#......#.......#.###.......#..###..................#......#................................#.........
.#........#...........###...#...##.#.......#.#....................................##..............................#...........#....
.......................#....##....#......................#..#.......................#.....#.#..#.#.....##.......#........#.........
......##..#....#.....#..................#.#..............###....#.....#...##.................#.#.........#................#........
....#..#..#.....#..........#........#.......#..................#..........#.#.............#..........####.....#..##...#....#.....#.
..#........#.......#......#.........#....................#..........#.#..#............#..........##..#...............#..#..........
..........#..#..........#..#.......................##....#....#......#.#..#...#........#..........#........#....#..................
..##........#..........##..#..........#...............#..#....#....#..#........##................................#....#............
............#...#.#......#......#.....#.#............#..#..#..##..#...#...................................#.....#............#...#.
....#.....................#.###.....................#.#..............#..#..#...#.............#..................#.............#....
.....#.#..#..........##.#.#......#...#....................#....#..#.....#...#.#............#......#.....................#......#...
............#..#.#..#....#...#.#..#..................#.#...#............#.##.......##................#............#.#.#......#.....
..#.#.....#........##..##.........##............#....#.....#.#..#.....#..#..#...#..#..........#...#.....#.........#...#............
..#.#.........##....##..............................#..#..#....#...#..#...#...................#...............#..#..............#..
.............#....#...#..........#.#........#....#.#...#..#.#..#..#.....#..##...##...#.............#.#..........##.#..#..##.....##.
...................#............................#.....#.#.#..................#....#......................#.###.....#..#............
.#...#..#.#.........#.............................................#.#..#.#..............##.............#........#....#.............
..........##...#.###...........................#.....##.....#..............#....#...#....#.....................#......#.......#.#..
...#....................................#...#..............#..#..............#......................##....#.#..##..........#.......
..#..#...#...#.###....#..#.#.#..........................................#........#.....................................#....#......
.........#..##...#...#...##...........#......#.....#..............##.......#......##..........................##.#....##...........
.##.....##...#...####.......#........##.........#.................#................#....#....#........#.............#..#...##......
......#....#............#.##.........#...#........##..##.#.....#............#.................##...............................#...
...#....#..........................#..#......................###......##....#...###.#..........#..............#............#.......
.........#......##.......................................#..............##.......##..#........................#..............#.#.#.
...........##.........##.......................###.##........#......#......##...#.............................###.#........#.......
......#.......##...............#......##.................#.#.........##.......#.........#....#...............#...#.#...#....#....#.
..............#.......#.........##..#....#.#.......#...........#........#.....#...##..........#..#............#...#........#.....#.
..#....#....#.#..#...........#...#...................................#......#.#................................#.....#....#........
.....#..........#...#.........#...#.............#.#....#.......#............#.#...#....#....##.....#..........#....#.....#.........
.....#...........#..............#.........#......#..#....#..#..#...................#....#............#.................#...#....#..
................##................#....................#..#.................#....#.#...#.........#.#...##.................#........
............................#...#........#....#............#..#.#....#.......#.#......#..#.........#................#.....###....#.
..........#.................#......#............#..#..........#.....#..#.....#...##.......#.#....#..................#..#...........
.##........#................#..#.......##..............#............##............#.......#.#.....#.........................###..#.
......#...#...........#.#.............#..#...#....#..#....#.#..............#............#.......#........#.........................
...#...##.#..................#.......#.................#....#..#..........#.......#.....#..#........###..##................#.......
..##.#.................##..................##.....#..........#........#..#.......##.#.........#..........................#.........
..........#..........#.....................##.....#....##.............#.#....#....#..#...#..................#.................#....
.......##..............#...#...#......##.......#..#.............#.................#...#.#...............................#..##......
........................................#...#......##...........#.....#...#..........#...#.#....##........#......#...........#..#..
................#.......#................##....#...#...#....................................##.......#...#.#......#..............#.
....#................................#.#.....#..................#......##..#.....#....#...........#................#.......##......
.....##......................#...........#.#........#....#..#.....##...........###..#..#......#..#.#....#.........#.............##.
..#...............#.#.............#...#....................#.......#.##......#......#................##.....#...#..................
...#.........#..##.........#.#...#..#.#...#.#.........#.#...#.....#...#...............#..#.#.#.......##............................
.#..........#..#......#....#.................#.....#.....##...#.#..#.....#.#..#..#.#..#.#........#.............#...................
............#..#.#...#.#..##.##..#.....#.........#...#............##............#.#...#................#.........##.#...#..........
.#..............##......#....#...#.#.....#..##.............#......#..#.............#...#.......................#........#..........
..........#.....#...#.#.......#....#.#...#.....##.........##.......#..................#.......#.........#.....#.....##.............
..........#..#.......#....##....##......#.....#........#.#.....#..#......#.........#.......#.....#.###.....#........#..............
.............#...........##.#.................#.##.#.....#.#.#.........................#...##.....#...#......#...#.................
.....#.....##...###..#.....#.......##.......#........#........##...#......................#..........#...#.##.....#....#.#.........
.................................................................S.................................................................
.....#.#.......#...............#.#...........#........##...........#....#......#....#..##....#.#..#.#........#.....#.....#.........
................#..................#........#.#............#...............##..#.......#...##..#...##......#.##...........##.......
...........###..#..##.................#..#.#.....#....#...##.#...................................#............#..#.......###.......
....................#..........#.#...#.#....#........#.#....#.........#...........#....#............##..............#..............
.#...........#..##.#.....#.#....##.....#.....#.....#..........##.................#.#.....................###.#...##................
...........#.......##...........#....#..................#..........#............##............#........#...............#...........
.............#.............#..............##......#.............#..#...##............#.........#.....#.#..#........................
..#...........#..#.....#...#....#........#..#.....##............#.#.#.........................#.#..#.#.....#.......#.#...........#.
.....#..........#......#.....#...........#............#..#.#......#...#.....#..#.....#...........#.#.....#.#....................##.
..............##..#...##...##.........#..........#..#....##..#.....#........#........#...#.....................#...................
...............###................#.#.......#..#........#....##.#.##..##.#....#.#.......#..#.#....#.#........##..#..............##.
...#.#.................#...#..##...#........#.....#..........................#...........#.....#..........................#..#..#..
........#.........#.....#..................#....#.#...#...#..#..#....###.............#.#...#.....#.............#.#........#...#....
.........................................#..........##.......#......#....#.......#.............#...##......................#.......
.....##....#......................#............#........#.##...........#....#........#.....#...#.............#...........#.....#...
....#......................................##..#.#.#.#.....#...............#......#..........#.......#................#...###......
.........#...........#.......#..#.........#.###.....#...#.......#...................#....##........#.........#..........#.#.##.....
..........................#............##......#.#.#........##.....#....................#.......#..#...............................
...#...........#................#....##...##..........#............#....#..#..........#...............##..............#.#..#...#...
................#..........##.#...#...#.............#.....#..#.........##...#.#.##....###..#...........................#....#......
.#...##.......#..#.........#####.........##.#..#...#....#.....#....#...#........##.........#..#..........#.........................
......#.#...#...................#.###..................#...............#........#............#.........#........#.......#....#.....
..#............#...........#.........#.......#......#.............#.#...##....##.....#....#.........#.................#......#.....
...#.#......................#...#............#.##.......#.#.........#..................##.#....#.................#............#....
..........#.........#...............#......................#......#.#...#.#....##...#.........#..#.#............#.......#..#.......
....#.#..#..##......#.#.......#......#........#...#...#..#..#.##..#...........##.....#......................##.....#...#...........
............#......#..#.............#..................#.....#.......#....#..#...............#...............#..#......#.#..#....#.
...............#................#.......#.#..........#.#.............#........#..#...#.#.......#..#.....................#..#..#..#.
..##..............###...............#.....#.....##.....#..#.##..........#.#.........#....##................#........#...#.....##...
....#..#.#..#.#.....#...#.........##.#..#..#....#..#...##...####.........##.........#.........................#..........#...#...#.
..................#...#..............#.......#........#....................#......#...#......##...........#.#...#................#.
......#...#............#...#.......................#...#.......#...#.....##...............................#..#..#................#.
..................#......##..#...........#.#.....#.......#...#......#....#.......#..#.#...#.............#..#...........#...........
........##.....#....#....##.#............#.......#....#..#..##..............##...#........#.#.........#.#..#.....#......#..##......
...#....................#.................#.#....##..##.#..#....#.##...............#..................#.#.#...........#......#...#.
..................#......#......#.........#.#......##.......#.#.............##......##....................#..#.....................
.....#.#.#.....#....#....##....#.............#....#............#..#....#........##.........................#..#............#.......
............................#................#...#.........#...........#......#.#......#....................#.#......###.....#.....
..#...........#...........#................#.....#.........#...........##.#..#....#....#..................#..#.##.##.......#...#...
....#....................#........#....................##..............##.....#.#.....................#.#.................#...#....
................#.#.......#...................#.....#...#...#.#....#.###......#....#...............#.......#...............#.......
...#..#.........#.#............#....................#......#.........##..#..........#.........#..#.....#.#..#......#..#.....#..#...
.....##..#...#.....#.............#....................................#..##..................##.#.#..........#...#.##.....#...#....
........#.....#...#..#..#..#.##.....#..............#............#..##.#...##.....#............#..#..#....##...#....#...............
.............#....#.....#....#.#.......#.............##...#..#..........#...#............#..###................#....#.......###....
....#....#..#........#...##.........#....................#..#...........#..#..#..............#.#.#........#....#..#........##...#..
..................#............#........#.....................#...........#.##.#.........#........##........#......................
.#....#.......#.........#..#..#.##...................#.............#..#.................#.#...#.........#.#...........#........##..
...#..........#..............#......#..#.#...#.........##....#..........#.............#..#...............#.........#..........#....
...#..#..#.....#......#..#...#...............#..........#................#....................#...#...##..#.........##.#...........
.......#.............................#.......................#..#.......#...............#......#...##.#..#..........#......#.......
.#....#..#.........#..#...##......#....#..................#....##...............................#.##...................#....#...#..
...#...#..............#....#.....#.........#....#.......................#.........#.........#................#......#.#...#..#.....
...#.......#.#.............#....#...#...........................#...............#.........##.........#...#....#.....###......#.##..
...#....#..#.#.............#......#...#................................#..........####...#.#.........#.#...............#...#....#..
......#........#.##........#...........................................................#......#....................#..#..#......#..
..#........#.......#..#.#.#...........##...#...................#..#.........................#........#.........#.....#.#......#.#..
.#..#......#...#..#.##.#....#...#.....#......##...................#.........##.#...#.........#..#.......#.....#....#..#....#.#.....
...#......#.#.#..............#..#......#..#............#.......##.#..............#...#..#...##...#.#....................#......#.#.
..#...........#....##..#.#......................#.##.##......................#..#......#....#....#.............................#...
......#............#....#....#....#......#.....#...#......................##.......#......#..##.....#.....###....#.#..........#....
..........#..............#............#.........#...##.#.#..............................#....#....#.#.#..#..#.......#.........#..#.
......#...#........#..........................#.........#........................#...#.................##.##...#....#...#..#.......
........#..............#.#......##.#........##....#.#.......#..........###...#...........##....#....#.......#...#..#.......#.#.....
...................................................................................................................................
"""
