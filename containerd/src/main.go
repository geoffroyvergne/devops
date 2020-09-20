package main

import (
    "context"
    "log"
    "github.com/containerd/containerd"
    "github.com/containerd/containerd/namespaces"
)

func main() {
    if err := redisExample(); err != nil {
        log.Fatal(err)
    }
}

func redisExample() error {
    client, err := containerd.New("/run/containerd/containerd.sock")
    if err != nil {
        return err
    }
    defer client.Close()



    return nil
}