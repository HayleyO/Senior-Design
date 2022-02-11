using System;

using Android.App;
using Android.Widget;
using Android.OS;
using Android.Support.Wearable.Activity;
using hearRINGAndroidWear.Sound;
using Xamarin.Forms;

namespace hearRINGAndroidWear
{
    [Activity(Label = "@string/app_name", MainLauncher = true)]
    public class MainActivity : WearableActivity
    {
        TextView textView;

        protected override async void OnCreate(Bundle bundle)
        {
            base.OnCreate(bundle);
            SetContentView(Resource.Layout.activity_main);

            textView = FindViewById<TextView>(Resource.Id.text);
            SetAmbientEnabled();

            MessagingCenter.Subscribe<Record, double>(this, "Volume", async (sender, arg) =>
            {
                Android.Widget.ProgressBar soundBar = FindViewById<Android.Widget.ProgressBar>(Resource.Id.soundBar);
                soundBar.SetProgress((int)arg, true);
                if (arg <= Chunking.SoundLevels[SoundChunks.Green])
                    soundBar.ProgressDrawable.SetColorFilter(Android.Graphics.Color.Green, Android.Graphics.PorterDuff.Mode.Multiply);        
                else if(arg <= Chunking.SoundLevels[SoundChunks.Yellow])
                    soundBar.ProgressDrawable.SetColorFilter(Android.Graphics.Color.Yellow, Android.Graphics.PorterDuff.Mode.Multiply);
                else
                    soundBar.ProgressDrawable.SetColorFilter(Android.Graphics.Color.Red, Android.Graphics.PorterDuff.Mode.Multiply);
            });

            while (true)
            {
                await Record.StartAsync();
            }
        }
    }
}


