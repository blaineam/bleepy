import argparse

from bleepy import (AudioFile, ProfanityBlocker, ProfanityExtractor,
                    SpeechToText, VideoFile)

stt = SpeechToText()
profanityExtractor = ProfanityExtractor()
profanityBlocker = ProfanityBlocker()
video = VideoFile()
audio = AudioFile()


parser = argparse.ArgumentParser("bleepy")
parser.add_argument("output", help="Where to save the bleeped video", type=string)
parser.add_argument("video", help="What video to bleep", type=string)
parser.add_argument("bleep", help="What sound to use for bleepy", type=string)
args = parser.parse_args()

profanityBlocker.set_save_directory(args.output + "/bleeped video")
profanityBlocker.set_clips_directory(args.output + "/clips")

video.set_file(args.video )
audio.set_file( args.bleep )

stt.run(video)
profanityExtractor.run(stt.get_results())

profanities = profanityExtractor.get_profanities()
profanityBlocker.run(video,audio,profanities)

print("List of Profanities Detected")
for profanity in profanities:
    print(profanity["word"])

print("The Bleeped file saved in: "+profanityBlocker.get_file_location())
