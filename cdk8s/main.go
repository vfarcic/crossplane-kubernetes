package main

import (
	"github.com/cdk8s-team/cdk8s-core-go/cdk8s/v2"
)

type MyChartProps struct {
	cdk8s.ChartProps
}

func main() {
	app := cdk8s.NewApp(nil)
	NewCivoCk(app, "civo", nil)
	NewCivoCkAll(app, "civo-all", nil)
	app.Synth()
}
