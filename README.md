# Galperin-Collisions
[*Max Murphy*](https://m053m716.github.io/ "Author's website") | 2020-11-25

Can a system of imaginary 1-D pool balls help us relate the physiology of spike trains to the generation of smooth, complex movements? Skip ahead to the [**Motivation**](#motivation "Why have you done this?") section if this is a little too "out-there" for you right now. Otherwise, if you are looking to get up and running with this simple repository for simulations, read on!

## Contents

1. [**Getting Started**](#Startup)

2. [**Background**](#background)

   a. [**Neurobiology**](#neurobiology)

   	+ [**Figure 1:** Animation of membrane voltage changes propagating along axon during an action potential.](#figure-1 "The fundamental unit of communication in the nervous system is the action potential. Spike train analysis consists of detecting the precise times of spike peaks, then re-expressing those peaks as sums of impulse functions with different offsets relative to the start of a record. In extracellular recordings, the action potentials from many units are typically recorded simultaneously, requiring more sophisticated characterization of the population-level spike trains.")
   	+ [**Figure 2:** Example of spikes in extracellular field that correspond to putative action potentials.](#figure-2 "Different colors indicate clusters that have been manually curated or 'sorted' as dictated by the waveform morphology of roughly 30 samples centered around the peak. Sorting was more prevalent in the past, but with the advent of higher-density recording arrays it may be less-needed.")
   	+ [**Figure 3:** Example of field potentials recorded by invasive electrodes.](#figure-3 "Spikes are detected from the extracellular local field potentials (LFP). The LFP is highly state-dependent in terms of its characteristics, indicating the importance of considering models capable of accounting for discrete or discrete-like phase transitions in the neural state space.")
   	+ [**Figure 4:** Example of movement-related spiking in extracellular field potentials.](#figure-4 "There are 'bursts' of activity evident in both the timing of discrete spiking 'events' as well as the fluctuations in the local field potential, in synchronization with discrete components of movement. These signals are distributed throughout sensorimotor cortex in the rat.")

   b. **[Applied Math](#applied-math)**

3. **[Motivation](#motivation)**

   a. **[Problem Statement](#problem-statement)**

   b. **[Specific Aims](#specific-aims)**

   	+ [**Figure 5:** Example of polyphasic spiking evoked from rat sensorimotor cortex in response to mechanical stimulation.](#figure-5 "While traditional models of motor control have typically relied upon correlations between the neural state (defined by spike counts) and movement, even without movement present, simple somatosensory mechanical inputs result in complicated response patterns in sensorimotor units.")
   	+ [**Figure 6:** Use of state-space reconfiguration to predict counts of billiard collisions in simple 1-D dynamical system.](#figure-6 "By relating elastic collisions in a simple dynamical system with a few masses or walls constrained to have biologically-plausible system parameters, is it possible to get a more intuitive sense for how discrete impulses relating to motor control are converted to force-generating movement commands?")

4. **[Strategy](#strategy)**

   a. **[Inverse Modeling of Dynamics](#inverse-model)** 

   b. **[Biomechanical Simulations](#simulated-robot-arm "Use of a robotic arm as an endpoint for model validation.")**

   	+ [**Video 1:** Supination about the Elbow](#video-1)

   

## Startup
* Simply run `main.m` (assuming you have **[Matlab R2020b](https://www.mathworks.com/downloads/web_downloads/download_release?release=R2020b "I am not sure what the earliest version that works would be. Maybe R2019a+?")** or comparable and the full set of academic licenses).

* Use the following command from the Command Window with the Matlab Editor navigated to the `~/Galperin-Collisions` folder (or whatever you named the folder containing the `.git` pertaining to this repository on your local file system) to see information about functions and how to use them. Remember that workflow all originates from `main.m` and should be good to run "as-is". 

  * If you are unfamiliar with Matlab, to run `main.m` simply navigate in the Matlab Workspace browser to whatever directory you have saved the contents of this repository to on your local machine. This can be done manually through the editor, or from the Command Window by inputting the command (the parts after "`>>`") corresponding to your machine's operating system. To input a command, press `enter` after putting in the whole line. To enter a multi-line command, press `shift + enter` to start inputting on a new line.
  
  ```matlab
  >> cd "C:\Your\Folder\Here";    % Windows-style directories
  >> cd "/home/your/folder/here"; % UNIX-style directories *maybe
  ```
  
  * Once you have navigated to the local version of this folder, you can double-check that you are in the correct folder in your Matlab Workspace by entering the following command to your Command Window in the Editor, which will return the current folder of the Matlab Workspace:
  
  ```matlab
  >> pwd % Print the current directory to the Command Window
  ```
  
  * If the prior command returns the correct location where you have saved this folder, then you are in the right place. To run `main.m`, you can either manually click the green "Run" play-button in the `Editor` tab of the Editor interface, or from the Command Window you can input the command to run the script.
  
  ```matlab
  >> main % Run the main.m script
  ```
  
  * Successfully running `main.m` should result in figures similar to [**Figure 6**](#figure-6 "State-space phase diagram for counting the number of collisions in the system.") and **[Figure 7](#figure-7 "Time- and frequency-content of the system, representing the collisions as impulses convolved with an arbitrary waveform and superimposing noise.")** shown in this README. 
  * To learn about the different functions contained in this repository, refer to the built-in documentation that is formatted to work with the Matlab environment using `Contents.m` and stereotyped header syntax on each function document.
  
  ```matlab
  >> help Contents % Prints formatted short-version "Help" summary with links to longer documentation in Command Window.
  >> doc Contents  % Pulls up separate window with HTML-ish formatted help reference sheet.
  ```

---

## Background

I was watching **[this YouTube video](https://www.youtube.com/watch?v=jsYwFizhncE&vl=zh-CN)** (produced by the excellent channel, **[3Blue1Brown](https://www.youtube.com/channel/UCYO_jab_esuFRV4b17AJtAw)**, which is constantly putting out high-quality math-related content), and once I heard the **[sounds "attached" to the simulated collisions](https://youtu.be/jsYwFizhncE?t=383)**, it clicked for me. I'm 75% confident that this will become a fundamentally useful physical model for describing a dynamical system capable of relating the smooth generation of movement to the "discrete" outputs of neurons, which ultimately result in muscle-recruitment and force-generation that enable the smooth, online control of movement. 

### Neurobiology

#### What are ***Spikes***?

*[Return to Table of Contents](#Contents)*

**[Neurons](https://en.wikipedia.org/wiki/Neuron)** communicate in a variety of ways, but the traditional one that jumps to mind (perhaps because it is the most directly-evident and was the primary phenomenon under study in the **[Giant Squid](https://en.wikipedia.org/wiki/Hodgkin%E2%80%93Huxley_model)** axons of **[Hodgkin](https://en.wikipedia.org/wiki/Alan_Hodgkin)** and **[Huxley](https://en.wikipedia.org/wiki/Andrew_Huxley)**'s experiments) is the **[action potential](https://en.wikipedia.org/wiki/Action_potential)**. 

##### Figure 1

*[Return to Table of Contents](#Contents)*

![](https://upload.wikimedia.org/wikipedia/commons/9/95/Action_Potential.gif "Illustration of the propagating ionic current inside a cell during an action potential.")

> **As a nerve impulse travels down the axon, there is a change in polarity  across the membrane.** The Na+ and K+ gated ion channels open and close in response to a signal from another neuron. At the beginning of action  potential, the Na+ gates open and Na+ moves into the axon. This is  depolarization. Repolarization occurs when the K+ gates open and K+  moves outside the axon. This creates a change in polarity between the  outside of the cell and the inside. The impulse continuously travels  down the axon in one direction only, through the axon terminal and to  other neurons. **(*Linked animation and caption hosted on Wikipedia and contributed by Laurentaylorj - Own work, CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=26311114*)**

We observe the **[action potential](https://en.wikipedia.org/wiki/Action_potential "spike")** as a change in voltage near a recording electrode and with reference to a secondary reference electrode (often called "ground"). The location of the ground depends on nature of the recordings; in extracellular, a reference may be placed on the cortical surface while a secondary ground, designed to remove biological sources of noise such as the electromyographical signals associated with chewing or other activity of the muscles around the head, is tied to a skull screw or other attachment point. For both intracellular and extracellular recordings, the rapid influx of sodium currents that occur after the voltage-gated sodium ion channels open following the membrane reaching a "critical" voltage threshold results in a decidedly "spike-like" change in the recorded voltage with respect to time and by comparison with the rest of the fluctuations in voltage signal. The nomenclature **"spikes"** is therefore made with reference to these approximately 300 - 3,000 Hz waveforms that appear to be, well, "spike-like" compared to the other arbitrarily slow voltage fluctuations in electrophysiological recordings.

##### Figure 2

*[Return to Table of Contents](#Contents)*

![](https://raw.githubusercontent.com/m053m716/Galperin-Collisions/main/img/Example-Spikes.PNG "Example of spike sorting from a single recording channel in Layer 5 of the rat motor cortex.")

> _**Example of spike sorting from a single extracellular recording channel in Layer 5 of the rat motor cortex.** The largest **"spikes"** (such as the 0.2-mm+ peak-to-peak spikes in the red grouping) most likely originate from large pyramidal cells located approximately 1.5-mm from the dorsal surface of the rat's cortex. Note that in the **"out"** cluster, many waveforms have been attributed as artifact. Such artifact can occur for a number of reasons, which include but are not limited to: vibrations due to motion; impedance mismatch between reference and recording electrode leading to demodulation of AM radio signals; electromyographical signals in the 300 - 3,000 Hz range, such as occur due to chewing; intermittent capacitive discharge due to improper charge balance in stimulation paradigms; apparent spiking due to saturation of the analog-to-digital converter and associated numeric overflow problems; or fluctuations in system power due to asynchronous devices recruited during experimental execution. (Source: Graduate studies of **[Max Murphy](https://m053m716.github.io/)** in Randy Nudo's lab at University of Kansas Medical Center.)_

I have always studied extracellular field potentials, so any further mention of "spikes" is with respect to the "**[neural unit](https://en.wikipedia.org/wiki/Neuron#History "putative neuron")**," a vague piece of jargon, which from what I can gather appears to refer to the fact that the neuron is the "fundamental unit" of the nervous system, whatever that means. I use the term as a capitulation: 

> "We aren't actually sure *which* neuron contributed these spikes, but we think it is somewhere around *here*." 

"*Here*" is also a bit vague, but it is probably fair to say that it is on the order of 0.10 - 0.25 millimeters from the recording electrode. This depends on quite a few factors, such as the impedance of the recording electrode and the size, orientation, and type of the cells that might be nearby. 

##### Figure 3

*[Return to Table of Contents](#Contents)*

![](http://www.scholarpedia.org/w/images/0/05/8EEGs2.jpg "Local Field Potentials (LFP) are highly correlated on spatial scales that depend upon which networks are actively being recruited in the generation of a particular neural *state*")

> **Local field potentials in cats during   wake and sleep states.**  Eight bipolar tungsten electrodes   (inter-electrode distance of 1 mm) were inserted into the depth   (1 mm) of areas 5-7 of cat [parietal cortex](http://www.scholarpedia.org/article/Parietal_cortex) (suprasylvian gyrus, area   5-7; see top scheme for arrangement of  electrodes).  Local field   potentials (LFPs) are shown (left panels)  together with a   representation of the correlations as a function of  distance   (Spatial correlations; middle panels) and time (Temporal    correlations; right panels).  A. When the animal was awake, LFPs   were  characterized by low-amplitude fast activities in the   beta/gamma  frequency range (15-75 Hz).  Correlations decayed steeply   with  distance and time.  B. During slow-wave sleep, the LFPs were   dominated by large-amplitude slow-wave complexes recurring at a low   frequency (<1 Hz; up to 4 Hz).  Correlations stayed high for large   distances.  C.   During episodes of REM sleep, LFPs and correlations   had similar  characteristics as during wake periods (* indicates a   PGO wave). Modified from Destexhe et al., 1999. ***(Linked figure and caption hosted by Scholarpedia and contributed by Alain Destexhe. http://www.scholarpedia.org/article/File:8EEGs2.jpg)***

While modern electrodes often have tens if not hundreds of electrodes along a single shank, making the challenging **[inverse-source localization problem](http://www.scholarpedia.org/article/Source_localization "where is the source producing this field potential change?")** more tractable and giving greater confidence in the spatial localization of observed neural units, it remains a fact that as of 2020, many experiments performed even with 32- or 64-channel extracellular arrays do not have adequate sensor data to perform localization with high confidence. **In general, this does not matter**, as the precise spatial locale on scales below this accuracy is somewhat inconsequential if we are simply trying to get an idea if neurons in one area of the brain or another respond to a stimulus or become active during a movement. However, as interests in **[Hodology](https://en.wikipedia.org/wiki/Connectomics "connectomics")** have sky-rocketed over the past decade with technological advances enabling some studies to employ the number and resolution of sensors required to parse cell-type-specific information about connections *in vivo,* so it is likely that this statement and associated sentiment will find themselves quite outdated by the time 2030 rolls around.

#### What are ***Spike Trains***?

*[Return to Table of Contents](#Contents)*

We refer to a series of spikes in sequence, which are thought to originate from a conserved neural unit of interest, as a **"train."** In the study of motor neurophysiology, spike trains are typically of interest around **[movement](#movement "'Grasp' or other similar movement components")** events of note. 

##### Figure 4

*[Return to Table of Contents](#Contents)*

![](https://raw.githubusercontent.com/m053m716/Galperin-Collisions/main/img/Example-Spike-Trains.PNG "Bandpass-filtered extracellular field potentials from rat cortex during a reach-to-grasp pellet retrieval.")

> _**Spike trains are evident in ["bursts"](http://www.scholarpedia.org/article/Bursting "Not necessarily the same as Network Bursts, but maybe related?") surrounding movement event of interest during a reach-to-grasp pellet retrieval task, on the timescale of hundreds of milliseconds.** Each horizontal trace represents a different recording channel from an array embedded extracellularly in approximately Layer 5 of the rat cerebral sensorimotor cortex. "Greener" channels indicate a lower RMS value in the passband (300 - 3,000 Hz), while "redder" channels indicate a higher RMS value in the passband. Note that the higher RMS does not necessarily mean that it is a "noisy" channel -- it could also simply be a very "active" channel with rapid spiking activity, which might be contributed by multiple different units. The magenta dashed-lines indicate behavioral events that were identified by scoring videos of the reaching animal at the associated timestamp. "Arpeggio" refers to the spreading of the digits by the rat just prior to closing them about the pellet, denoted by "Grasp." Even without doing an explicit detection of spikes in these recordings, it is evident that "spike-like" activity around each of these events "ramps up" and then wanes during intervening intervals: **it seems more likely that cortex drives transitions between discrete "volitional" states, which may "look like" phases of behavior but which are probably specific to how individuals learn to execute any given motor task.** (Source: Graduate studies of Max Murphy in Randy Nudo's lab at University of Kansas Medical Center.)_

There are [**many**](http://www.scholarpedia.org/article/Category:Spiking_Networks) ways to **[analyze spike trains](https://rcweb.dartmouth.edu/~mvdm/wiki/doku.php?id=analysis:nsb2016:week9)** for point-processes occurring in biological neural networks. However, the use of spike trains (generally, many spike trains collected in parallel from some population(s) of interest during a given experimental task) as a control signal for moving an effector typically follows a predictable methodology wherein there are currently two conflicting schools of thought: the "**[dynamical systems](https://www.nature.com/articles/nature11129 "For example: 'Churchland and his followers' -- Lebedev (2019) criticisms")**" people and the "[**sequence-of-tunings**](https://www.nature.com/articles/s41598-019-54760-4 "For example: Andy Schwartz at NeuroNexus Tech talks in November 2020")" people. Please do not ask me about which I think is correct.

#### What is ***Movement***?

*[Return to Table of Contents](#Contents)*

While **"movement"** could easily refer to many things, it should be defined here as the constituent components of volitional, nuanced movements such as a reach-to-grasp. When I say "movement," I am usually thinking about something like "grasping," which would entail the hundreds of milliseconds just before and just after the closing of all the digits simultaneously. My graduate studies did not focus on reflexive control of movement, so I cannot pretend to know much in that area other than that there are certain canonical reflexes that are generally important and which I should expect to be present even during volitionally controlled behaviors. However, this definition simply hopes to capture the idea that here when "movement" is mentioned, I am thinking about whatever it is that goes through the brain just prior to reaching for a coffee mug, as well as the ensuing act of grasping the cup and retrieving it to the mouth.  

### Applied Math

#### What is an ***elastic collision***?

*[Return to Table of Contents](#Contents)*

According to Wikipedia, an **[elastic collision](https://en.wikipedia.org/wiki/Elastic_collision)** is

> ...an encounter between two bodies in which the total kinetic energy of the two bodies remains the same...

For example, if there are two fixed walls at either end of a 1-dimensional rail and a ball is started rolling at one end of the rail, then assuming no other forces act on the ball as it rolls, it will continue to bounce back and forth indefinitely between the two containing walls. If collisions with either wall were inelastic, resulting in the loss of kinetic energy from the system comprised by the rolling ball and walls, then the ball would eventually stop rolling.

#### Who is ***Galperin***?

*[Return to Table of Contents](#Contents)*

**[Gregory Galperin](http://www.ux1.eiu.edu/~cfgg/ "Guy who I assume likes playing pool")** is an applied mathematician. "**[Galperin's Billiards](https://www.mdpi.com/2227-7390/8/4/509/htm)**" are an abstract 1-dimensional system comprised of a wall, a small billiard ball at rest, and a large billiard ball moving toward the small billiard ball from the side opposite the wall. In [**this paper**](https://maths.tcd.ie/~lebed/Galperin.%20Playing%20pool%20with%20pi.pdf) (pdf version is included with this repository), Galperin shows that this system can be used to very accurately estimate the value of *π* to any arbitrary precision by scaling the mass of the large ball as desired and then counting the number of ensuing collisions. This is because of the reframing of the problem of counting the balls using a state-space that relies on transforming combinations of the balls' masses and velocities while understanding the fundamental constraints on the bounds of the state-space describing the joint position and velocity of the balls. When the square root of the mass of the large ball is a factor of ten greater than the square root of the mass of the small ball, the resulting number of collisions becomes an increasingly accurate approximation of *π* as the mass of the large ball increases. While the appeal of accurately estimating *π* is not lost on me, the processes I am proposing to use relating physical collisions to neurophysiological spike trains are not really *Galperin's* per se. Rather, in learning about his work sparked my imagination about how we could make use of the dynamics of billiards as an intuitive descriptor for what is happening in the brain as it tries to control moving limbs during behavior. 

#### Why ***billiards***?

*[Return to Table of Contents](#Contents)*

Why not? **[Billiards](https://en.wikipedia.org/wiki/Cue_sports "A game that the author is terrible at.")** are not only an enjoyable pastime, but more importantly, the complicated behavior of the moving and stationary objects, along with the constraining "boundary" walls, forms an interesting and rich basis for dynamical systems analogies. For a simple person like me, abstract or esoteric concepts are often unattainable and therefore a highly visual analogy provides a more accessible way to conceptualize how such a system might work. Often, I have been unable to describe phenomena related to the processing of network or population dynamics even though in my opinion they are neither abstract, esoteric, or even complicated; in my opinion this is because the formulation and description of these models does not lend itself to clear visual analogy in a way that is immediately apparent without an over-long (and difficult) explanation of the supposed neurobiological underpinnings. 

Unlike most network dynamics analogies, which seem to either provide too abstract a painting to hang one's "visual hat" on, or else dramatically oversimplify a system to the point where it seems so abstracted from anything that could be possibly relevant (such as the commonly-invoked swinging pendulum system), the applicability of the billiards system in relating spiking network activity to a smooth output function should be easier for the neurophysiologist. I will reiterate that for me, it was clear as soon as I heard the "clicking" sound (and its "ramping" and fading, especially) from each collision that this could be a useful analogy for the timing of spikes in relation to movements. This is because during *in vivo* extracellular field potential recordings, it is often desirable to attach an audio monitor to the voltage signals, which have a distinctive "sound" when *real* physiological signals are acquired and quite characteristic "sounds" otherwise (for example, apparently spike-like activity is easily distinguished as demodulated sports radio signals by *listening* to it, despite the novelty and utility purported by certain fancy "de-noising" machine learning techniques). 

Many times, I've heard spikes "burst" in this similar fashion--for example when detecting sensory field responses to cutaneous stimuli on a single electrode recording channel. While the clicking produced by ball-ball or ball-wall contact during the estimation of π is "too uniform" (suggesting that the simplest 1-D model with a rigid wall and only two moving masses is **too simple**, as could be probably intuited regardless), I believe that with only very slight complications the system could be utilized efficaciously in either describing or engineering processes related to the common neuroscientific problem of relating discrete impulses to continuous functions. While [**many**](https://lcnwww.epfl.ch/gerstner/SPNM/node7.html) methods for "**[spike rate estimation](https://en.wikipedia.org/wiki/Neural_coding#Rate_coding)**" or "**[smoothing](http://users.isr.ist.utl.pt/~pjcro/temp/Applied%20Optimal%20Estimation%20-%20Gelb.pdf)**" exist (and probably continue to be developed), most of these methods fundamentally treat the observed timings as stochastic (I have always thought this is the best or most useful way to think of it, at any rate). So, in a certain sense this is also a capitulation on my part that **perhaps we can do better**: even if we need to use stochastic theory in some parts of our neuroscientific models, I think that we could produce a method of rate estimation that actually tells us something of use when it comes to the processes at play in generating whatever rate we have observed, which is done directly during the process of rate estimation.

---

## Motivation

*[Return to Table of Contents](#Contents)*

I am not interested in the properties of a simple system of **[elastic collisions](#elastic-collisions)** as they relate to number theory and the accurate estimation of *π*, although that is an interesting application in its own right. Instead, there are two ways that I see the systems described in **[Galperin's billiards model](#Who-is-Galperin)** as being helpful to **[motor systems neuroscience](#neurobiology)** at large. To see why this is, we must first address the problem:

### Problem Statement

*[Return to Table of Contents](#Contents)*

While **[spikes](#What-are-Spikes)** are "discrete" sequences of impulses, **[movements](#What-is-Movement)** are smooth and continuous. Most attempts to relate the two for brain-computer-interface (BCI) control require a stochastic treatment of discrete spikes as noisy point processes; however, generalizing this to populations of spiking neurons makes it difficult to intuitively understand how the population is "controlling" the movement. Biophysically realistic networks of spiking neurons (e.g. simulations using Hodgkin-Huxley or other deterministic equations of spike generation) **[have been demonstrated](http://www.netpyne.org/)**, but require an abundance of parameters, high numbers of units in each simulated population in order to maintain accuracy, and may not offer simplifying insights. Artificial neural networks relying on **[deep learning techniques](https://www.nature.com/articles/s41592-018-0109-9)** to "**[open the black box](https://www.mitpressjournals.org/doi/full/10.1162/NECO_a_00409)**" of computations relating to dynamics of neural populations during movement or processing of stimuli seem to offer similar challenges in the process of regularizing and improving intuition from the expanded complexity associated with the model. **Can we make a simpler deterministic model that is not only useful but <u>intuitive</u> in both the analysis of spike trains and their efficient integration into BCI controllers?**

### Specific Aims

*[Return to Table of Contents](#Contents)*

Resolving this **[problem](#problem-statement)** requires working on it from either end in opposed direction: on one side, fundamental descriptive laws facilitating the implementation and realization of such a system must be developed (or, if they exist, I need to learn about them); on the other side, the utility of realizing a control system from this perspective must be tested empirically. As such, this requires two Specific Aims: the **[first](#applied-math-objective)** in the area of applied mathematics and the **[second](#systems-engineering-objective)** in the area of control systems engineering. 

#### Applied Math Objective

*[Return to Table of Contents](#Contents)*

- [ ] **Specific Aim 1 develops a method to quickly estimate the basis system parameters from an observed sequence of [impulses](#What-are-Spikes).**

I would like to simplify the description of any **[spike train](#What-are-Spike-Trains)** observed during **[movements](#What-is-Movement)** (or, any stimulus that elicits a [**complex polyphasic spiking response**](#figure-5), for that matter). 

##### Figure 5

*[Return to Table of Contents](#Contents)*

<img src="https://raw.githubusercontent.com/m053m716/Galperin-Collisions/main/img/Example-Polyphasic-Response.png" title="Example of polyphasic stimulus response for unit activity on a single recording channel in Layer 5 of Rat Sensory Cortex." style="zoom:45%;" />

> _**Example of polyphasic stimulus response in layer 5 of rat sensory cortex.** Stimuli, such as cutaneous "interactions" wherein an object comes into contact with the rat's digit or paw, (here, via a light mechanical solenoid tap, indicated by the grey shaded region) do not occur instantaneously. There is a propagation delay required between the stimulus and the time of evoked activity in cortex. Furthermore, the contact takes place over some epoch of time (here, the dwell time is set experimentally to 50-ms). These stimuli may happen in combination with other "real" stimuli (magenta arrow indicates a single intracortical microstimulation (ICMS) pulse introduced to the rostral forelimb area, RFA). Red bullseyes denote the expectation of evoked spiking activity at relative onset latencies compared to the time of trial onset, which coincides with the ICMS pulse.  The dashed magenta threshold indicates the value taken as a threshold for that particular channel in defining candidate "evoked" peaks, which are refined using a peak finding algorithm that is built into Matlab (`findpeaks`, Matlab R2020b). The expectation (y-axis) is estimated from the smoothed spiking responses counted in 5-ms bins, which are then averaged on a per-bin basis over 100 repeated trials using this combination of ICMS and Solenoid extension/retraction timings and targeted to the same location on the paw. The polyphasic response (over the course of 100-200 milliseconds) observed in this experiment for this unit is not uncommon; note that this is an anesthetized rat that is not actively performing a behavior; therefore, it is likely that during active behavior, even more complicated responses could occur, scaling in complexity with the behavioral requirements. (Source: Graduate studies of **[Max Murphy](https://m053m716.github.io/)** in Randy Nudo's lab at University of Kansas Medical Center; data to-be-published in collaboration with **Page Hayley**.)_

This response could be re-expressed in many ways. One way would be to re-express it as a scaled sum of one or a few sine and cosine components, which may give information about the frequency content in the data. The [**Fourier Transform**](https://en.wikipedia.org/wiki/Fourier_transform) is fundamentally a linear basis transformation that allows us to recover just this kind of information, which tends to be useful in many applications (and is applied extensively in neuroscientific research). Unfortunately, it is not always clear *what* it means when there are "dominant" frequencies in experiments. Do these frequencies represent time-constants of synaptic potentials, some arbitrary number of expected synapses and associated axonal conduction delays related to a **[salient recruited circuit](https://papers.cnl.salk.edu/PDFs/Thalamocortical%20Assemblies_%20How%20Ion%20Channels%2C%20Single%20Neurons%20and%20Large-Scale%20Networks%20Organize%20Sleep%20Oscillations%202001-3724.pdf)** that is directly involved in the response? Are they indicative of subthreshold entrainment to gross field potential fluctuations caused by populations of cells elsewhere, which might change extracellular ionic current concentrations and alter the probability of a cell spiking at a particular phase of a given "rhythm" via some indirect mechanism? While there are certainly "canonical" [**rhythms of the brain**](https://neurophysics.ucsd.edu/courses/physics_171/Buzsaki%20G.%20Rhythms%20of%20the%20brain.pdf) that have been described in relation to many phenomena, it should be noted that certain rhythms are mysteriously absent or "shift range" on a per-subject basis. My opinion is that these things are not quite as "cut and dry" as some literature makes them seem, although they are undoubtedly useful tools for thinking about how connections may work in the brain.  

Is there another model that we could apply to the observed responses in order to decompose them in a way that gives us an alternative intuition to what is offered when studying frequency content alone? Many neuroscientific studies are designed to do just that. For example, the "sequential tunings" motor systems neuroscientists often use paradigms involving a similar movement with a target destination that is oriented in many different locations relative to the starting position. By changing "one element" (the direction of movement), "tunings" are obtained by fitting a weighted cosine model to recover the preferred direction eliciting the largest change in spiking for a particular unit. In the beginning, this approach provided a fundamental and sizable improvement in understanding that eventually led to the development of some of the first brain computer interfaces (BCI); however, the fact that this strategy persists (and that some consider it the *only* viable way to look at neurophysiological data) is deeply troubling and indicates the state of affairs in motor systems neuroscience.  **What if we could develop a new kind of "tuning" that borrows from dynamical systems theory without "making it only about the dynamics"?** In this conception, rather than "tuning" to preferred directions, we consider a re-expression of movements in a "**[collision](#What-is-an-elastic-collision "Only dealing with elastic collisions for now.")**-basis" (or another better name- I'm bad at names); in this formulation, "tunings" are described by parametric components of a dynamical system of "colliding" components that is dictated by the *a priori* principled decision about what nervous circuit elements are involved in the movement of interest. This allows us to efficiently compute and describe the expected magnitude (a counted number of collisions: spikes) and time-traveled over a specified distance (the duration of the phase of movement related to some event) using only one or two coefficients (for example, in **[Figure 6](#figure-6)**, the number of collisions given by only changing the mass of the "large" component can be computed quite efficiently). To start with, these parameters include:

* Number of colliding objects, ***N***
* Masses ***m*** of each object.
* Starting distances ***d*** of each object.
* Starting velocities ***v*** of each object.
* If "walls" are non-fixed, then the way the "walls" move might change in a few ways:
  * "Wall-on-spring": what is **[Hooke's constant](https://en.wikipedia.org/wiki/Hooke%27s_law "spring constant (k, in F = -kx)")** for each bounding wall?
  * "Viscoelastic Walls": what **[damping](https://en.wikipedia.org/wiki/Viscoelasticity#Kelvin%E2%80%93Voigt_model "Kelvin-Voigt model")** is placed in parallel to the "spring" attached to the bounding walls?

While this may initially seem like many parameters, realize that in many cases the parameters are held constant *a priori* due to principled decisions about the model. For example, if we are interested in the spiking of a single neuron, we could simplify the system by requiring that the ***m*** corresponding to that unit is equal to *1-kg* (as is the case in **[Figure 6](#figure-6)**). **The applied math problem is: given an observation and principled constraints on the underlying dynamical system, is there an efficient, deterministic method for estimating the required model parameters?**

##### Figure 6

*[Return to Table of Contents](#Contents)*

<img src="https://raw.githubusercontent.com/m053m716/Galperin-Collisions/main/img/Phase-Portrait--Multiple-Large-Weights.png" title="State-Space diagram for different numbers of collisions." style="zoom:50%;" />

> _**State-space diagram for three different mass ratios.** The x-axis represents a scaled value of the square-root of the mass of the small ball times its velocity, while the y-axis represents a scaled value of the square-root of the mass of the large ball times its velocity. Each time that the path collides with the unit circle, the balls collide and the velocity of the small ball changes directions, causing it to "jump" to the top half of the circle. This continues until the large ball has changed direction and has a greater velocity than the small ball, at which point the small ball cannot "catch up" to the large ball In this example, the light-red path with **N = 11** was obtained when the mass of the small ball is equal to 1-kg and the mass of the large ball is equal to 10-kg. (Source: [`main.m`](https://github.com/m053m716/Galperin-Collisions/blob/main/main.m), via the [`plotPhaseSpace`](https://github.com/m053m716/Galperin-Collisions/blob/main/plotPhaseSpace.m) function included in this repository.)_

#### Systems Engineering Objective

*[Return to Table of Contents](#Contents)*

- [ ] **Specific Aim 2 develops the simplest control system model capable of [moving](#What-is-Movement) a segmental limb model to a target end-point while using "[Galperin's Billiards](#Who-is-Galperin)" model parameters as the control signals.**

The engineering motivation is somewhat the opposite. Could a system based on parameters describing the distance to a wall or series of walls, the properties of collisions between that wall and masses along some axis affording contact with said wall, and arbitrary choices of mass size, initial velocities, and initial distances between colliding entities be used to generate smooth (responsive) movements to an end-point target? Because each of these things is tied to a concrete analogy, it should not be difficult to relate it to some component within the *in vivo* network and by extension use this intuition to help formulate a better BCI controller.

Put alternatively, supposing that there is a speculative distribution of positive and negative coefficient weightings on impulses within a network, which allow the generation of force along some subset of axes (i.e. muscles, which move in relation to one another). Could we use this heuristic model (**[Galperin's billiards](#who-is-galperin)**) as a starting-point to make a simple analogy for explaining what is happening with different interacting system sub-circuits during behavior?

It is readily shown that this system is readily used to produce "spike-like" trains that are similar to those observed during the activation of neural units correlated to a particular movement event during behavior, as shown in **[Figure 6](#figure-6)**, below.

##### Figure 7

*[Return to Table of Contents](#Contents)*

<img src="https://raw.githubusercontent.com/m053m716/Galperin-Collisions/main/img/Time-Freq.png" title="State-Space diagram for different numbers of collisions." style="zoom:75%;" />

> _**Proof-of-concept simulation of time-series and frequency content for collision time-series generated by model.** (Top) The time-series is simply a series of impulses inserted at the corresponding sample indices denoted by the model-determined time-of-impact between the small ball and the wall or larger ball. Each collision is denoted by an impulse; here, the impulse has been convolved with an arbitrary spike-like shape; subsequently, noise was added to the distribution (as part of a process of audio export but not necessarily having immediate value other than conditioning the smoothing estimator--the blue line indicating approximate instantaneous firing rate--in this case). (Bottom) An analytical description of the frequency content is one of the challenges that could be addressed from the applied-math side: can we make a description of the expected frequency content produced by the system given mass, velocity, and distance-to-the wall, from the outset? (Source: [`main.m`](https://github.com/m053m716/Galperin-Collisions/blob/main/main.m), via the [`plotSeries`](https://github.com/m053m716/Galperin-Collisions/blob/main/plotSeries.m) function included in this repository.)_

---

## Strategy ##

*[Return to Table of Contents](#Contents)*

### Inverse Dynamics ###

*[Return to Table of Contents](#Contents)*



### Simulated Robot Arm ###

*[Return to Table of Contents](#Contents)*

There are two Matlab `Class` definitions that essentially define the architecture of the simulated robot arm, which in its infancy is a series of cylindrical segment rigid bodies connected by revolute joints with one degree of freedom. The lack of other kind of joints reflects the current limitations of Matlab built-in classes to handle this in the robotics toolkit; however to effectively get the same degrees of freedom as a ball and socket joint it is possible to "stack" the revolute joints using very short rigid segments to "link" them such that the robot is still a reasonable approximator to the range of motion of the forelimb.

#### Video 1 ####

*[Return to Table of Contents](#Contents)*

<iframe width="1108" height="623" src="https://www.youtube.com/embed/VIDEO_ID?playlist=83vmhuoM90I&loop=1&modestbranding=1&rel=0&controls=0" frameborder="0" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>