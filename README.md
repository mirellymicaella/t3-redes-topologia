# T3 Redes - Roteamento

Para executar, basta chamar o script desejado. Por exemplo, para rodar a primeira topologia, bastar
executar:

```yml
./script_1.sh
```

Dessa forma, todos os roteadores serão "levantados" e também conexões/janelas do Telnet para cada
roteador serão abertas.

**Obs: pode ser necessário ajustar o tempo de sleep (sleep 5) entre os comandos para iniciar os roteadores e o
comando para abrir os terminais telnet devido ao tempo necessário para "subir" os roteadores ser diferente em
cada computador...*
Para finalizar tudo, basta chamar o script com a flag "-k":

```yml
./script_1.sh -k
```

Para realizar alguns testes, basta entrar no telnet correspondente e rodar os seguintes comandos: (neste
caso um exemplo para o ip pode ser 58.16.1.1 por exemplo)

```yml
ping <ip> /vrf v1
traceroute <ip> /vrf v1
```

Para desativar alguma interface, entrar no menu de configuração, depois no menu da interface desejada e
por fim o comando shutdown. Por exemplo:

```yml
conf t
int eth1
shutdown
```
