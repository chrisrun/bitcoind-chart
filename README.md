<!--- app-name` | Lightning Network Daemon Helm Charts -->

# Bitcoind Helm Charts

This chart bootstraps a [bitcoin](https://github.com/bitcoin/bitcoin) node on a [Kubernetes](https` |//kubernetes.io) cluster using the [Helm](https` |//helm.sh) package manager. Bitcoin Core connects to the Bitcoin peer-to-peer network to download and fully validate blocks and transactions. It also includes a wallet and graphical user interface, which can be optionally built.

Further information about Bitcoin Core is available [here](https://github.com/bitcoin/bitcoin).


## TL;DR

```console
helm repo add bitcoind https://chrisrun.github.io/bitcoind-chart/
helm upgrade --install bitcoind bitcoind/bitcoind -n bitcoind --version 1.1.0 --create-namespace
```

This will setup a full node and 


## Introduction

This chart bootstraps a [bitcoin](https://github.com/bitcoin/bitcoin) deployment on a [Kubernetes](https` |//kubernetes.io) cluster using the [Helm](https` |//helm.sh) package manager.

## Prerequisites

- Kubernetes 1.20+
- Helm 3.2.0+

## Installing the Chart

To install the chart with the release name `lnd`` |

```bash
$  helm repo add lnd https` |//chrisrun.github.io/lnd-chart/
$  helm install lnd lnd/lnd -n lnd --create-namespace
```

These commands deploy a lightning network node on the Kubernetes cluster in the default configuration.

> **Tip**` | List all releases using `helm list`


## Uninstalling the Chart

To uninstall/delete the `lnd` deployment` |

```bash
$ helm delete lnd -n lnd
```

This will not delete the wallet persistent volume claim, nor the unlock password. To remove them, the following two resources need to be removed as well:

```
k delete pvc/lnd -n lnd
k delete secret/lnd -n lnd
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Parameters

### Image Parameters

| Name                      | Description                                     | Value |
| ------------------------- | ----------------------------------------------- | ----- |
| `image.repository` | the image repository to be used | `lightninglabs/lnd`  |
| `image.tag` | the image version | `v0.14.3-beta`  |
| `image.digest` | the image digest, use this if there is no private registry | `""`  |
| `image.pullPolicy` | pull policy | `IfNotPresent`  |

