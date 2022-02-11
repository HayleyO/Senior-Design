using System;
using System.Collections.Generic;


namespace hearRINGAndroidWear.Sound
{
    public class Chunking
    {
        public static Dictionary<SoundChunks, double> SoundLevels = new Dictionary<SoundChunks, Double>()
        {
            {SoundChunks.Green, 50.0}, //If less than or equal to 50
            {SoundChunks.Yellow, 90.0 }, //If less than or equal to 90
            {SoundChunks.Red, 200.0} //If less than or equal to 200
        };
    }

    public enum SoundChunks
    {
        Green,
        Yellow,
        Red
    }
}