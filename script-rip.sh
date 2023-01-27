RTR=rtr.jar
HWSW=rip/joanelly-

# Executando os roteadores
tmux new-session -d -s rare 'java -jar '$RTR' routersc '$HWSW'r1-hw.txt '$HWSW'r1-sw.txt'
tmux split-window -v -t 0 -p 50
tmux send 'java -jar '$RTR' routersc '$HWSW'r2-hw.txt '$HWSW'r2-sw.txt' ENTER;
tmux split-window -h -t 0 -p 50
tmux send 'java -jar '$RTR' routersc '$HWSW'r3-hw.txt '$HWSW'r3-sw.txt' ENTER;
tmux split-window -h -t 0 -p 50
tmux send 'java -jar '$RTR' routersc '$HWSW'r4-hw.txt '$HWSW'r4-sw.txt' ENTER;
tmux select-layout tiled;

echo "Iniciando roteadores..."
sleep 5 # 5 segundos de espera para iniciar os roteadores

tmux new-session -d -s telnet 'telnet localhost 26001'
tmux split-window -v -t 0 -p 50
tmux send 'telnet localhost 26002' ENTER;
tmux split-window -h -t 0 -p 50
tmux send 'telnet localhost 26003' ENTER;
tmux split-window -h -t 0 -p 50
tmux send 'telnet localhost 26004' ENTER;
tmux select-layout tiled;

tmux a;