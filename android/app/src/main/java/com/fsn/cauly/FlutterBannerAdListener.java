package com.fsn.cauly;

import androidx.annotation.NonNull;

import com.fsn.cauly.CaulyAdView;
import com.fsn.cauly.CaulyAdViewListener;

public class FlutterBannerAdListener implements CaulyAdViewListener {
    protected final int adId;
    @NonNull
    protected final AdInstanceManager manager;

    FlutterBannerAdListener(int adId, @NonNull AdInstanceManager manager) {
        this.adId = adId;
        this.manager = manager;
    }

    @Override
    public void onReceiveAd(CaulyAdView caulyAdView, boolean isChargeableAd) {
        manager.onReceiveAd(adId, isChargeableAd);
    }

    @Override
    public void onFailedToReceiveAd(CaulyAdView caulyAdView, int errorCode, String errorMessage) {
        manager.onFailedToReceiveAd(adId, errorCode, errorMessage);
    }

    @Override
    public void onShowLandingScreen(CaulyAdView caulyAdView) {
        manager.onShowLandingScreen(adId);
    }

    @Override
    public void onCloseLandingScreen(CaulyAdView caulyAdView) {
        manager.onCloseLandingScreen(adId);
    }
}