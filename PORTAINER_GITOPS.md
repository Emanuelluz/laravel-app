Deploy via Portainer (GitOps)

1) Repositório Git
- URL do repositório: https://github.com/Emanuelluz/laravel-app
- Branch: main
- Caminho do Compose: /docker-compose.yml

2) Configurar Stack no Portainer
- Acesse Portainer > Stacks > Add stack > Git repository
- Cole a URL do repositório e selecione a branch `main`.
- Em "Compose path", coloque `/docker-compose.yml`.
- Opcional: habilitar "Auto update" para Git polling (ou configure um webhook se preferir).

3) Variáveis sensíveis e Secrets
- Não comite segredos. Altere `docker-compose.yml` para referenciar secrets ou use Portainer Secrets.
- Configure credenciais do banco e APP_KEY nas Secrets ou no ambiente da stack.

4) Observações
- Este compose monta o código diretamente no container (bind-mount). Em produção, prefira imagens construídas e não usar mounts.
- O serviço `app` usa `php-fpm`; certifique-se de executar `composer install` e `php artisan key:generate` durante a build ou via comandos remotos.
- URLs locais após deploy:
  - Aplicação: http://<IP-DO-SERVIDOR>:8080
  - phpMyAdmin: http://<IP-DO-SERVIDOR>:8081

5) Fluxo GitOps
- Sempre que fizer push em `main`, se o Portainer estiver configurado para auto-update, a stack será atualizada automaticamente.
- Para atualização mais controlada, use tags/branches e atualize a stack manualmente.
