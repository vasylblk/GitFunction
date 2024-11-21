import unittest
import time
from server import TrigServer

class TestServer(unittest.TestCase):
    def test_elapsed_time(self):
        start_time = time.time()
        values = [math.sin(x) for x in range(1000000)]
        sorted_values = sorted(values)
        elapsed_time = time.time() - start_time
        self.assertTrue(5 <= elapsed_time <= 20)

if __name__ == '__main__':
    unittest.main()
