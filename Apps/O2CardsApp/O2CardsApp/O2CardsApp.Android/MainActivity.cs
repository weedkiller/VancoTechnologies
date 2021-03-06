
using Android.App;
using Android.Content.PM;
using Android.OS;
using Plugin.Permissions;
using Plugin.CurrentActivity;
using Android.Content;

namespace O2CardsApp.Droid
{
    [Activity(Label = "O2 Cards", Icon = "@drawable/icon", Theme = "@style/O2Cards.Splash", MainLauncher = true, ConfigurationChanges = ConfigChanges.ScreenSize | ConfigChanges.Orientation)]
    public class MainActivity : global::Xamarin.Forms.Platform.Android.FormsAppCompatActivity
    {
        protected override void OnCreate(Bundle savedInstanceState)
        {
            TabLayoutResource = Resource.Layout.Tabbar;
            ToolbarResource = Resource.Layout.Toolbar;

            base.OnCreate(savedInstanceState);
            global::Xamarin.Forms.Forms.Init(this, savedInstanceState);

            ZXing.Mobile.MobileBarcodeScanner.Initialize(Application);
            
            LoadApplication(new App());
            
            CrossCurrentActivity.Current.Init(this, savedInstanceState);
            CrossCurrentActivity.Current.Activity = this;
        }

        public override void OnRequestPermissionsResult(int requestCode, string[] permissions, Android.Content.PM.Permission[] grantResults)
        {
            PermissionsImplementation.Current.OnRequestPermissionsResult(requestCode, permissions, grantResults);
        }

        public void Share(string filepath)
        {
            var intent = new Intent(Intent.ActionSend);
            intent.SetType("text/vcard");
            Java.IO.File file = new Java.IO.File(filepath);

            intent.PutExtra(Intent.ExtraStream, Android.Net.Uri.FromFile(file));

            var intentChooser = Intent.CreateChooser(intent, "Share vCard");
            Android.App.Application.Context.StartActivity(intentChooser);
        }
    }
}