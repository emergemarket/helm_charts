[![Release Charts](https://github.com/emergemarket/helm_charts/actions/workflows/main.yml/badge.svg)](https://github.com/emergemarket/helm_charts/actions/workflows/main.yml)
## TL;DR

```bash
$ helm repo add emergemarket https://charts.emergemarket.io
$ helm install my-release emergemarket/my-chart
```

## Chart submission
Develop your chart and either push to main or submit a PR to main. When the push is performed or PR merged GHA will fire an action to automatically register your chart to the helm repository. Upon subsequent updates to your chart the patch level will automatically increment. Major and minor versions will be set within the chart itself.

The helm "bump-chart-version" github action is the work of New Relic and can be found here: https://github.com/newrelic/helm-charts
