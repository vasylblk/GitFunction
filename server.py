import time
import math
import json
from http.server import BaseHTTPRequestHandler, HTTPServer

class TrigServer(BaseHTTPRequestHandler):
    def do_GET(self):
        start_time = time.time()
        # Генерація масиву значень тригонометричної функції
        values = [math.sin(x) for x in range(1000000)]
        sorted_values = sorted(values)
        elapsed_time = time.time() - start_time

        response = {
            "sorted_values_sample": sorted_values[:10],
            "elapsed_time": elapsed_time
        }
        self.send_response(200)
        self.send_header("Content-type", "application/json")
        self.end_headers()
        self.wfile.write(json.dumps(response).encode())

if __name__ == "__main__":
    server = HTTPServer(("0.0.0.0", 8080), TrigServer)
    print("Server started at http://0.0.0.0:8080")
    server.serve_forever()
