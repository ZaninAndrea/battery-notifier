package main

import (
	"fmt"
	"time"

	gosxnotifier "github.com/deckarep/gosx-notifier"
	battery "github.com/distatus/battery"
)

func main() {
	const threshold float64 = 0.80

	batteryInfo, err := battery.Get(0)
	if err != nil {
		panic(err)
	}

	previousLevel := batteryInfo.Current / batteryInfo.Full
	for {
		time.Sleep(30 * time.Second)

		batteryInfo, err = battery.Get(0)
		currentLevel := batteryInfo.Current / batteryInfo.Full
		if err != nil {
			panic(err)
		}

		if currentLevel >= threshold && previousLevel < threshold && batteryInfo.State == battery.Charging {
			note := gosxnotifier.NewNotification(fmt.Sprintf("Battery reached %2.f%%", threshold*100))
			note.Title = "Battery Alert"
			note.Sender = "com.baida.notifybattery"
			err := note.Push()
			if err != nil {
				panic(err)
			}
		}

		previousLevel = currentLevel
	}
}
