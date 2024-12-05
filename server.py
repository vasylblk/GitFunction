import time
from http.server import BaseHTTPRequestHandler, HTTPServer

# Реалізація функції e^x
def ex(x, terms=20):
    result = 1.0  # Початковий член (x^0 / 0!)
    term = 1.0    # Поточний член
    for n in range(1, terms):
        term *= x / n  # Обчислення наступного члена
        result += term
    return result

# HTTP-сервер
class MyServer(BaseHTTPRequestHandler):
    def do_GET(self):
        start_time = time.time()
        
        # Генерація масиву значень e^x
        n = 10000  # Кількість елементів у масиві
        array = [ex(i * 0.001) for i in range(n)]
        
        # значень e^x для перевірки
        print(f"First 10 values of e^x: {array[:10]}")
        
        array.sort()

        elapsed_time = time.time() - start_time
     
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(f"Elapsed time: {elapsed_time:.2f} seconds\n".encode("utf-8"))

# Запуск сервера
def run_server():
    host = "localhost"
    port = 8080
    server = HTTPServer((host, port), MyServer)
    print(f"Server running on {host}:{port}")
    server.serve_forever()

if __name__ == "__main__":
    run_server()
