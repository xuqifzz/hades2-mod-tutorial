ManaDataStore = {}

ManaGatherAnimations = 
{
	Default = "MelManaGather",
	OOM = "MelManaGatherOOM"
}

ManaIndicatorPresentation = {
	AutoComplete = 
	{
		TransitionIn = "ManaChargeIndicatorIn",
		Fill = "ManaChargeIndicatorFill",
		Cancel = "ManaChargeIndicatorCancel",
		Dissipate = "ManaChargeIndicatorDissipate",
	},
	Hold = 
	{
		TransitionIn = "ManaChargeIndicatorIn",
		Fill = "ManaChargeIndicatorFill",
		Loop = "ManaChargeIndicatorHoldLoop",
		Cancel = "ManaChargeIndicatorCancel",
		Dissipate = "ManaChargeIndicatorDissipate",
	},
	SprintPowerBadge = "ManaChargeIndicatorDifferentMove",
	DifferentMoveBadge = "ManaChargeIndicatorDifferentMove",
	PerfectChargeBadge = "ManaChargeIndicatorDifferentMove",
	LastMomentManaRestoreEligibleHSV = {-0.2, 0, 0}
}