# Ultimate Security System (USS)
By L2B-19: Hiren Khurana, Joshua Yellowley, Marco Ser, Nicholas Ng
## Project Description
This is a state-of-the-art security system with facial recognition combined with a pin input to control the locking mechanism. Using a DE1-SoC, we have achieved this desired behaviour through connecting a touchsreen, a graphical user interface (GUI), a UART communication channel, a motor, a wifi chip, and a cloud instance. Initially, profiles will be stored on the cloud. When an attempted unlock occurs, first the user will be prompted to input a pin into the pinpad displayed on the touchscreen. On failure, the user will be propted back to the pinpad. On success the user will be prompted with the camera display. Then, an image taken by the user will be uploaded to the cloud and compared with a set of reference images using Microsoft Azure's Face API. If successful, then the cloud will return true and otherwise it will return false. This response will be emailed to the mailing list for this profile. Upon the response returning to the DE1-SoC, it will check whether both the pinpad and the facial recognition are both successes. If and only if this is the case, then it will unlock the motor.
## Project Scope

![alt text](https://github.com/UBC-CPEN391/l2b-19/blob/main/Project%20Scope.png)
## Project Setup

![alt text](https://github.com/UBC-CPEN391/l2b-19/blob/main/USS_Image.jpg)
