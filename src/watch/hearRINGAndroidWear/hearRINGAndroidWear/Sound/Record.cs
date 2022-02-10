using Android.Media;
using System;
using System.Threading;
using System.Threading.Tasks;
using Xamarin.Forms;

namespace hearRINGAndroidWear.Sound
{
	public class Record
	{
		/// <summary>
		/// Record class to start recording, check recording status, and end recording.
		/// Taken from xamarin docs.
		/// </summary>
		private static byte[] audioBuffer = null;
		private static AudioRecord audioRecord = null;
		static bool endRecording = false;
		static bool isRecording = false;

		public Boolean IsRecording
		{
			get { return (isRecording); }
		}

		public static async Task ReadAudioAsync()
		{
			while (true)
			{
				if (endRecording)
				{
					endRecording = false;
					break;
				}
				try
				{
					// Keep reading the buffer while there is audio input.
					int numBytes = await audioRecord.ReadAsync(audioBuffer, 0, audioBuffer.Length);
					//// Decibal calculations taken from: https://titanwolf.org/Network/Articles/Article?AID=51e51d5f-b37d-417b-9d3a-eee2ddb71e75
					long v = 0;
					//Take out the contents of the buffer and perform the square sum operation
					for (int i = 0; i < audioBuffer.Length; i++)
					{
						v += audioBuffer[i] * audioBuffer[i];
					}
					//Divide the sum of squares by the total length of the data to get the volume.
					double mean = v / (double)numBytes;
					double volume = 10 * Math.Log10(mean);
                    MessagingCenter.Send(new Record(), "Volume", volume); //Kind of hacky to enter the subscription, but....
					Console.WriteLine(volume);	
				}
				catch (Exception ex)
				{
					Console.Out.WriteLine(ex.Message);
					break;
				}
			}
			audioRecord.Stop();
			audioRecord.Release();
			isRecording = false;
		}

		protected static async Task StartRecorderAsync()
		{
			endRecording = false;
			isRecording = true;

			audioBuffer = new Byte[10000];
			audioRecord = new AudioRecord(AudioSource.Mic,11025,ChannelIn.Mono,Android.Media.Encoding.Pcm16bit,audioBuffer.Length);

			audioRecord.StartRecording();

			// Off line this so that we do not block the UI thread.
			await ReadAudioAsync();
		}

		public static async Task StartAsync()
		{
			await StartRecorderAsync();
		}

		public void Stop()
		{
			endRecording = true;
			Thread.Sleep(500); // Give it time to drop out.
		}
	}
}