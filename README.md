# gocron-etcd-elector-example

A production environment replica of multiple instance job scheduling with leader and follower nodes

# Usage

Clone this repo
```git clone https://github.com/seriouspoop/gocron-etcd-elector-example.git```

Build and run containers with
`docker compose up --attach go-app`
attach flag will only show logs for go-app service

Alternatively
`docker compose up -d`
`docker compose logs -f go-app`

You will see something like this on your console

```
go-app-1| go-app
go-app-2| go-app
go-app-3| go-app
```

The etcd elector will choose a leader and run scheduled jobs
Only a leader is allowed to run jobs

```
go-app-[leader: any of 1/2/3]| Current instance is leader
go-app-[leader: any of 1/2/3]| executing job
```

Congratulations, you have your multiple instance gocron jon schedulers with high availibility up and running

To test the fail over stop the container elected as leader
`docker stop gocron-etcd-elector-example-go-app-[leader]`
replace `[leader]` with the leader container number,

Example,

```
docker stop gocron-etcd-elector-example-go-app-1
```

Then observe the logs to see new leader election
