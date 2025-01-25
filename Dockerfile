# Використовуємо офіційний образ Ubuntu
FROM ubuntu:20.04

# Оновлюємо список пакетів та встановлюємо Apache2 і Zabbix Agent
RUN apt-get update && \
    apt-get install -y apache2 zabbix-agent

# Вмикаємо автозапуск Apache2 при запуску контейнера
RUN systemctl enable apache2

# Налаштовуємо Zabbix Agent для моніторингу порту 80
RUN echo "Server=your_zabbix_server_ip" >> /etc/zabbix/zabbix_agentd.conf && \
    echo "Hostname=your_host_name" >> /etc/zabbix/zabbix_agentd.conf && \
    echo "UserParameter=check_apache_port,lsof -i :80" >> /etc/zabbix/zabbix_agentd.conf

# Відкриваємо порт 80 для Apache2
EXPOSE 80

# Запускаємо Apache2 і Zabbix Agent у фоновому режимі
CMD service apache2 start && zabbix_agentd -f
