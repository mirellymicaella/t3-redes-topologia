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

# Topologia 1 
Rede da topologia 1

Na topologia 1, temos uma rede com 5 elementos, implementada com roteamento estático.

Testes realizados na Topologia 1

## Mostrando a tabela de rotas para ipv4 e ipv6:

`show ipv4 route v1`

![image](https://user-images.githubusercontent.com/45270882/214974499-606ecaa5-a29a-44f4-b76c-2819a867fac2.png)

`show ipv6 route v1`

![image](https://user-images.githubusercontent.com/45270882/214974662-ac5685ce-1e3a-417e-a808-f9c87b2a5ef6.png)

## Teste de ping e traceroute no roteador R1 para o roteador R2 usando ipv4:

```C
ping 20.19.66.1 vrf v1
traceroute 20.19.66.1 /vrf v1
```

![image](https://user-images.githubusercontent.com/45270882/214976281-d19e0e7e-00b6-4b0b-8d0e-8eb050e5e19f.png)


Teste de ping e traceroute no roteador R1 para o roteador R2 usando ipv6:

```C
ping 2019:66:1::1 /vrf v1
traceroute 2019:66:1::1 /vrf v1
```
![image](https://user-images.githubusercontent.com/45270882/214976317-3d425edb-2bef-46c9-bcd7-2f7c88eee158.png)
