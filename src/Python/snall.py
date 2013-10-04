'''
Created on Sep 27, 2013

@author: xio

Matrix geometry (space-separated x, y): 9 9
Starting position (space-separated x, y): 3 3
42 43 44 45 46 47 48 49 82
41 20 21 22 23 24 25 50 83
40 19  6  7  8  9 26 51 84
39 18  5  0  1 10 27 52 85
38 17  4  3  2 11 28 53 86
37 16 15 14 13 12 29 54 87
36 35 34 33 32 31 30 55 88
63 62 61 60 59 58 57 56 89
98 97 96 95 94 93 92 91 90
'''

CARDINAL_DIRS = ['E', 'S', 'W', 'N']
DEBUG = False

class Agent(object):
    def __init__(self, cur_pos, env):
        self.env = env
        self.cur_pos = cur_pos
        self.faces = 'E'
        self.cur_i = 0
        self._put_i()
    
    def make_step(self):
        if self.faces == 'E':
            self.cur_pos = (self.x, self.y + 1)
        elif self.faces == 'S':
            self.cur_pos = (self.x + 1, self.y)
        elif self.faces == 'W':
            self.cur_pos = (self.x, self.y - 1)
        elif self.faces == 'N':
            self.cur_pos = (self.x - 1, self.y)
        self.cur_i += 1
        dbg(self.cur_pos)
        if self.x >= 0 and self.y >= 0 and \
                self.x <= (self.env.x - 1) and self.y <= (self.env.y - 1):
            self._put_i()

    def turn(self, direction):
        if direction == 'R':
            self.faces = CARDINAL_DIRS[(CARDINAL_DIRS.index(self.faces) + 1) % len(CARDINAL_DIRS)]
            dbg('now facing %s' % self.faces)
    
    def is_cell_free(self, direction):
        if direction == 'R':
            if self.faces == 'E':
                cell = self.env.get_i((self.x + 1, self.y))
            elif self.faces == 'S':
                cell = self.env.get_i((self.x, self.y - 1))
            elif self.faces == 'W':
                cell = self.env.get_i((self.x - 1, self.y ))
            elif self.faces == 'N':
                cell = self.env.get_i((self.x, self.y + 1))
        return cell is False
                
    @property
    def x(self):
        return self.cur_pos[0]
    
    @property
    def y(self):
        return self.cur_pos[1]
    
    def _put_i(self):
        dbg('putting %s at %s' % (self.cur_i, self.cur_pos))
        self.env.put_i(self.cur_pos, self.cur_i)
    

class Environment(object):
    def __init__(self, size):
        self.size = size
        self.field = self._gen_field(size)
        self.cells_filled = 0
        self.N = self.x * self.y
    
    @property
    def x(self):
        return self.size[0]

    @property
    def y(self):
        return self.size[1]

    @property
    def is_full(self):
#         return len(filter(lambda el: el is False, self.field.values())) == 0
#         return self.x * self.y <= self.cells_filled
        return self.N <= self.cells_filled
    
    def _gen_field(self, size):
#         return [False for _ in range(size[0]*size[1])]
        return {(x, y): False for x in range(size[0]) for y in range(size[1])}
    
    def show(self):
        lin_f = sorted(sorted(self.field.items(), key = lambda el: el[0][1]),
                       key = lambda el: el[0][0])
        i = 0
        while i < len(self.field):
#             print '%*s' % (len(str(self.size[0]*self.size[1])), self.field[i]),
            print '%*s' % (len(str(self.x * self.y)), lin_f[i][1]),
            i += 1
            if i % self.y == 0:
                print
        print '---'
    
    def put_i(self, pos, cur_i):
#         self.field[pos[0]*self.size[1] + pos[1]] = cur_i
        self.field[pos] = cur_i
        self.cells_filled += 1
    
    def get_i(self, pos):
        try:
            return self.field[pos]
        except:
            return False


def dbg(msg):
    if DEBUG: print msg

def X(n, step, start=0):
    if n == 0:
        return [start]
    else:
        temp = X(n-1, step, start)
        return temp + [temp[-1] + step]

def test():#{{{
    env = Environment((6, 3))
    env.show()
    print '---'
    env.put_i((2, 1), True)
    env.put_i((1, 0), 10)
    env.put_i((1, 1), 2)
    env.put_i((1, 2), 14)
    env.show()
    print '---'
    snall = Agent((1, 0), env)
    snall.make_step()
    env.show()
    snall.make_step()
    print '---'
    env.show()
    print snall.is_cell_free('R')
    print '---'
    env.put_i((2,2), 8)
    env.show()
    print '---'
    print snall.is_cell_free('R')
    snall.turn('R')
    snall.make_step()
    print '---'
    env.show()
    snall.turn('R')
    snall.turn('R')
    snall.turn('R')
    snall.make_step()
    snall.turn('R')
    snall.make_step()
    snall.turn('R')
    snall.make_step()
#}}}

def run(size, start_pos, show=True):
    env = Environment(size)
    snall = Agent(start_pos, env)
#     limit = 7 + sum(X(max(size[0], size[1]) - 3, 4, 11))
    while not env.is_full:
#     while snall.cur_i <= limit:
        snall.make_step()
        if snall.is_cell_free('R'):
            snall.turn('R')
    if show:
        env.show()

def test_speed():
    import timeit
    test_cases = [((50, 50),   (0, 0)),
                  ((100, 100), (0, 0)),
                  ((500, 500), (0, 0)),
                  ((500, 500), (0, 499)),
                  ((500, 500), (499, 0)),
                  ((500, 500), (499, 499)),
                  ((500, 500), (250, 250)),]
    for case in test_cases:
        print "%s matrix, starting at %s" % ((case[0]), (case[1]))
        print min(timeit.repeat("run(%s, %s, show=False)" % (case[0], case[1]),
                                setup="from __main__ import run",
                                number=1,
                                repeat=3))

def main():
    def str_pair_to_tuple(s):
        return tuple([int(n) for n in s.split()])
    size = str_pair_to_tuple(
            raw_input('Matrix geometry (space-separated x, y): ')
    )
    start_pos = str_pair_to_tuple(
            raw_input('Starting position (space-separated x, y): ')
    )
    run(size, start_pos)


if __name__ == '__main__':
    # test()
    import sys
    if len(sys.argv) > 1 and sys.argv[1] == 'test':
        test_speed()
    else:
        main()
