import psutil
import time
import ctypes
from pypresence import Presence

client_id = '1072194800247373936' # you can change this to your own in order to change the images n shit
RPC = Presence(client_id)
RPC.connect()
start_time = time.time()


def is_process_running(process_name):
    for proc in psutil.process_iter():
        try:
            if process_name.lower() in proc.name().lower():
                return True
        except (psutil.NoSuchProcess, psutil.AccessDenied, psutil.ZombieProcess):
            pass
    return False


if ctypes.windll.kernel32.GetConsoleWindow() != 0: # not neccessary unless you are not using "--noconsole"
    ctypes.windll.user32.ShowWindow(ctypes.windll.kernel32.GetConsoleWindow(), 0)

while True:
    if is_process_running("csgo.exe"):
        server_name = open("C:\\Program Files (x86)\\Steam\\steamapps\\common\\Counter-Strike Global Offensive\\csgo\\rpc_data.autism","r", encoding="utf-8") # change this if your csgo is located elsewhere
        player_stats = server_name.readline()

        RPC.update(state=server_name.read(), details=player_stats,
                   large_image="default_pfp", large_text="Primordial.dev",
                   small_image="csgo", small_text="Counter-Strike: Global Offensive", start=start_time)
        time.sleep(15) # updating the rpc every 15 seconds
    else:
        RPC.close() # it should close the connection and exit the app if csgo is not running anymore
        exit()
