## Commands

- Start the compose stack

  ```sh
  docker compose up
  ````

- Stop docker compose when it's running (actully most programs)

  `Ctrl + C` (Sends a Termination signal SIGINT)

- If we have made changes to containers we **build**
  
  ```sh
  docker compose up --build
  ````

- Ensure everything is cleaned up

  ```sh
  docker compose down
  ````

## Connecting to PostgreSQL instance from extension

- Connection string `postgresql://myuser@localhost:5432/mydatabase`
- Then add password to it's own field

## References

- [Traefik Proxy](https://doc.traefik.io/)
- [MinIO (Object Storge)](https://min.io/)
