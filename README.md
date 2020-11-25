# Galperin-Collisions
Can a system of imaginary 1-D pool balls help us relate the physiology of spike trains to the generation of smooth, complex movements? Skip ahead to the [**Motivation**](#motivation) section if this is a little too "out-there" for you right now. Otherwise, if you are looking to get up and running with this simple repository for simulations, read on!

## Contents

1. [**Getting Started**](#Startup)

2. [**Background**](#background)

   a. [**Neurobiology**](#neurobiology)

   b. **[Applied Math](#applied-math)**

3. **[Motivation](#motivation)**

## Startup
* Simply run `main.m` (assuming you have Matlab R2020b or comparable and the full set of academic licenses).

* Use the following command from the Command Window with the Matlab Editor navigated to the `~/Galperin-Collisions` folder (or whatever you named the folder containing the `.git` pertaining to this repository on your local file system) to see information about functions and how to use them. Remember that workflow all originates from `main.m` and should be good to run "as-is":

  ```matlab
  help Contents
  
  % or
  
  doc Contents
  ```

---

## Background

I was watching **[this YouTube video](https://www.youtube.com/watch?v=jsYwFizhncE&vl=zh-CN)** (produced by the excellent channel, **[3Blue1Brown](https://www.youtube.com/channel/UCYO_jab_esuFRV4b17AJtAw)**, which is constantly putting out high-quality math-related content), and at the point when the **[illustrated simulation got to the collisions with sounds "attached"](https://youtu.be/jsYwFizhncE?t=383)** to them it clicked for me. I'm 75% confident that this will become a fundamentally useful physical model for describing a dynamical system capable of relating the smooth generation of movement to the "discrete" outputs of neurons, which ultimately result in muscle-recruitment and force-generation that enable the smooth, online control of movement. 

### Neurobiology

#### What are Spikes?

**[Neurons](https://en.wikipedia.org/wiki/Neuron)** communicate in a variety of ways, but the traditional one that jumps to mind (perhaps because it is the most directly-evident and was the primary phenomenon under study in the **[Giant Squid](https://en.wikipedia.org/wiki/Hodgkin%E2%80%93Huxley_model)** axons of **[Hodgkin](https://en.wikipedia.org/wiki/Alan_Hodgkin)** and **[Huxley](https://en.wikipedia.org/wiki/Andrew_Huxley)**'s experiments) is the **[action potential](https://en.wikipedia.org/wiki/Action_potential)**. 

![](https://upload.wikimedia.org/wikipedia/commons/9/95/Action_Potential.gif "Illustration of the propagating ionic current inside a cell during an action potential.")

##### Figure 1

> **As a nerve impulse travels down the axon, there is a change in polarity  across the membrane.** The Na+ and K+ gated ion channels open and close in response to a signal from another neuron. At the beginning of action  potential, the Na+ gates open and Na+ moves into the axon. This is  depolarization. Repolarization occurs when the K+ gates open and K+  moves outside the axon. This creates a change in polarity between the  outside of the cell and the inside. The impulse continuously travels  down the axon in one direction only, through the axon terminal and to  other neurons. (*Linked animation and caption hosted on Wikipedia and contributed by Laurentaylorj - Own work, CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=26311114*)

We observe the **[action potential](https://en.wikipedia.org/wiki/Action_potential)** as a change in voltage near a recording electrode and with reference to a secondary reference electrode (often called "ground"). The location of the ground depends on nature of the recordings; in extracellular, a reference may be placed on the cortical surface while a secondary ground, designed to remove biological sources of noise such as the electromyographical signals associated with chewing or other activity of the muscles around the head, is tied to a skull screw or other attachment point. For both intracellular and extracellular recordings, the rapid influx of sodium currents that occur after the voltage-gated sodium ion channels open following the membrane reaching a "critical" voltage threshold results in a decidedly "spike-like" change in the recorded voltage with respect to time and by comparison with the rest of the fluctuations in voltage signal. The nomenclature **"spikes"** is therefore made with reference to these approximately 300 - 3,000 Hz waveforms that appear to be, well, "spike-like" compared to the other arbitrarily slow voltage fluctuations in electrophysiological recordings.

![](https://raw.githubusercontent.com/m053m716/Galperin-Collisions/main/img/Example-Spikes.PNG "Example of spike sorting from a single recording channel in Layer 5 of the rat motor cortex.")

##### Figure 2

> _**Example of spike sorting from a single extracellular recording channel in Layer 5 of the rat motor cortex.** The largest **"spikes"** (such as the 0.2-mm+ peak-to-peak spikes in the red grouping) most likely originate from large pyramidal cells located approximately 1.5-mm from the dorsal surface of the rat's cortex. Note that in the **"out"** cluster, many waveforms have been attributed as artifact. Such artifact can occur for a number of reasons, which include but are not limited to: vibrations due to motion; impedance mismatch between reference and recording electrode leading to demodulation of AM radio signals; electromyographical signals in the 300 - 3,000 Hz range, such as occur due to chewing; intermittent capacitive discharge due to improper charge balance in stimulation paradigms; apparent spiking due to saturation of the analog-to-digital converter and associated numeric overflow problems; or fluctuations in system power due to asynchronous devices recruited during experimental execution. (Source: Graduate studies of Max Murphy in Randy Nudo's lab at University of Kansas Medical Center.)_

I have always studied extracellular field potentials, so any further mention of "spikes" is with respect to the "**[neural unit](https://en.wikipedia.org/wiki/Neuron#History)**," a vague piece of jargon, which from what I can gather appears to refer to the fact that the neuron is the "fundamental unit" of the nervous system, whatever that means. I use the term as a capitulation: 

> "We aren't actually sure *which* neuron contributed these spikes, but we think it is somewhere around *here*." 

"*Here*" is also a bit vague, but it is probably fair to say that it is on the order of 0.10 - 0.25 millimeters from the recording electrode. This depends on quite a few factors, such as the impedance of the recording electrode and the size, orientation, and type of the cells that might be nearby. 

![](http://www.scholarpedia.org/w/images/0/05/8EEGs2.jpg "Local Field Potentials (LFP) are highly correlated on spatial scales that depend upon which networks are actively being recruited in the generation of a particular neural *state*")

##### Figure 3

> **Local field potentials in cats during   wake and sleep states.**  Eight bipolar tungsten electrodes   (inter-electrode distance of 1 mm) were inserted into the depth   (1 mm) of areas 5-7 of cat [parietal cortex](http://www.scholarpedia.org/article/Parietal_cortex) (suprasylvian gyrus, area   5-7; see top scheme for arrangement of  electrodes).  Local field   potentials (LFPs) are shown (left panels)  together with a   representation of the correlations as a function of  distance   (Spatial correlations; middle panels) and time (Temporal    correlations; right panels).  A. When the animal was awake, LFPs   were  characterized by low-amplitude fast activities in the   beta/gamma  frequency range (15-75 Hz).  Correlations decayed steeply   with  distance and time.  B. During slow-wave sleep, the LFPs were   dominated by large-amplitude slow-wave complexes recurring at a low   frequency (<1 Hz; up to 4 Hz).  Correlations stayed high for large   distances.  C.   During episodes of REM sleep, LFPs and correlations   had similar  characteristics as during wake periods (* indicates a   PGO wave). (Modified from Destexhe et al., 1999. *Linked figure and caption hosted by Scholarpedia and contributed by Alain Destexhe. http://www.scholarpedia.org/article/File:8EEGs2.jpg)*

While modern electrodes often have tens if not hundreds of electrodes along a single shank, making the challenging **[inverse-source localization problem](http://www.scholarpedia.org/article/Source_localization)** more tractable and giving greater confidence in the spatial localization of observed neural units, it remains a fact that as of 2020, many experiments performed even with 32- or 64-channel extracellular arrays do not have adequate sensor data to perform localization with high confidence. **In general, this does not matter**, as the precise spatial locale on scales below this accuracy is somewhat inconsequential if we are simply trying to get an idea if neurons in one area of the brain or another respond to a stimulus or become active during a movement. However, as interests in **[Hodology](https://en.wikipedia.org/wiki/Connectomics)** have sky-rocketed over the past decade with technological advances enabling some studies to employ the number and resolution of sensors required to parse cell-type-specific information about connections *in vivo,* so it is likely that this statement and associated sentiment will find themselves quite outdated by the time 2030 rolls around.

#### What are Spike Trains?

We refer to a series of spikes in sequence, which are thought to originate from a conserved neural unit of interest, as a **"train."** In the study of motor neurophysiology, spike trains are typically of interest around **[movement](#movement)** events of note. 

![](https://raw.githubusercontent.com/m053m716/Galperin-Collisions/main/img/Example-Spike-Trains.PNG "Bandpass-filtered extracellular field potentials from rat cortex during a reach-to-grasp pellet retrieval.")

##### Figure 4

> _**Spike trains are evident in ["bursts"](http://www.scholarpedia.org/article/Bursting) surrounding movement event of interest during a reach-to-grasp pellet retrieval task, on the timescale of hundreds of milliseconds.** Each horizontal trace represents a different recording channel from an array embedded extracellularly in approximately Layer 5 of the rat cerebral sensorimotor cortex. "Greener" channels indicate a lower RMS value in the passband (300 - 3,000 Hz), while "redder" channels indicate a higher RMS value in the passband. Note that the higher RMS does not necessarily mean that it is a "noisy" channel -- it could also simply be a very "active" channel with rapid spiking activity, which might be contributed by multiple different units. The magenta dashed-lines indicate behavioral events that were identified by scoring videos of the reaching animal at the associated timestamp. "Arpeggio" refers to the spreading of the digits by the rat just prior to closing them about the pellet, denoted by "Grasp." Even without doing an explicit detection of spikes in these recordings, it is evident that "spike-like" activity around each of these events "ramps up" and then wanes during intervening intervals: **it seems more likely that cortex drives transitions between discrete "volitional" states, which may "look like" phases of behavior but which are probably specific to how individuals learn to execute any given motor task.** (Source: Graduate studies of Max Murphy in Randy Nudo's lab at University of Kansas Medical Center.)_

There are [**many**](http://www.scholarpedia.org/article/Category:Spiking_Networks) ways to analyze spike trains for point-processes occurring in biological neural networks. However, the use of spike trains (generally, many spike trains collected in parallel from some population(s) of interest during a given experimental task) as a control signal for moving an effector typically follows a predictable methodology wherein there are currently two conflicting schools of thought: the "**[dynamical systems](https://www.nature.com/articles/nature11129)**" people and the "[**sequence-of-tunings**](https://www.nature.com/articles/s41598-019-54760-4)" people. Please do not ask me about which I think is correct.

#### What is "Movement"?

While **"movement"** could easily refer to many things, it should be defined here as the constituent components of volitional, nuanced movements such as a reach-to-grasp. When I say "movement," I am usually thinking about something like "grasping," which would entail the hundreds of milliseconds just before and just after the closing of all the digits simultaneously. My graduate studies did not focus on reflexive control of movement, so I cannot pretend to know much in that area other than that there are certain canonical reflexes that are generally important and which I should expect to be present even during volitionally controlled behaviors. However, this definition simply hopes to capture the idea that here when "movement" is mentioned, I am thinking about whatever it is that goes through the brain just prior to reaching for a coffee mug, as well as the ensuing act of grasping the cup and retrieving it to the mouth.  

### Applied Math

#### What is an elastic collision?

According to Wikipedia, an **[elastic collision](https://en.wikipedia.org/wiki/Elastic_collision)** is

> ...an encounter between two bodies in which the total kinetic energy of the two bodies remains the same...

For example, if there are two fixed walls at either end of a 1-dimensional rail and a ball is started rolling at one end of the rail, then assuming no other forces act on the ball as it rolls, it will continue to bounce back and forth indefinitely between the two containing walls. If collisions with either wall were inelastic, resulting in the loss of kinetic energy from the system comprised by the rolling ball and walls, then the ball would eventually stop rolling.

#### Who is Galperin?

**[Gregory Galperin](http://www.ux1.eiu.edu/~cfgg/)** is an applied mathematician. "**[Galperin's Billiards](https://www.mdpi.com/2227-7390/8/4/509/htm)**" are an abstract 1-dimensional system comprised of a wall, a small billiard ball at rest, and a large billiard ball moving toward the small billiard ball from the side opposite the wall. In [**this paper**](https://maths.tcd.ie/~lebed/Galperin.%20Playing%20pool%20with%20pi.pdf) (pdf version is included with this repository), Galperin shows that this system can be used to very accurately estimate the value of *π* to any arbitrary precision by scaling the mass of the large ball as desired and then counting the number of ensuing collisions. This is because of the reframing of the problem of counting the balls using a state-space that relies on transforming combinations of the balls' masses and velocities while understanding the fundamental constraints on the bounds of the state-space describing the joint position and velocity of the balls. When the square root of the mass of the large ball is a factor of ten greater than the square root of the mass of the small ball, the resulting number of collisions becomes an increasingly accurate approximation of *π* as the mass of the large ball increases.

![](https://raw.githubusercontent.com/m053m716/Galperin-Collisions/main/img/Phase-Portrait--Multiple-Large-Weights.png "State-Space diagram for different numbers of collisions.")

##### Figure 5

> _**State-space diagram for three different mass ratios.** The x-axis represents a scaled value of the square-root of the mass of the small ball times its velocity, while the y-axis represents a scaled value of the square-root of the mass of the large ball times its velocity. Each time that the path collides with the unit circle, the balls collide and the velocity of the small ball changes directions, causing it to "jump" to the top half of the circle. This continues until the large ball has changed direction and has a greater velocity than the small ball, at which point the small ball cannot "catch up" to the large ball In this example, the light-red path with **N = 11** was obtained when the mass of the small ball is equal to 1-kg and the mass of the large ball is equal to 10-kg._

While the appeal of accurately estimating *π* is not lost on me, I find this system sparked my imagination about how we could make some intuitive descriptions of what is happening in the brain as it tries to control moving limbs during behavior. 

#### Why billiards?

Why not? As stated from the outset, for me it was the **["clicking" sound](https://youtu.be/jsYwFizhncE?t=383)** made by the billiards in the video about how this method approximates *π* provided by **[3Blue1Brown](https://www.youtube.com/channel/UCYO_jab_esuFRV4b17AJtAw)** that immediately reminded me of the sound of spikes that I've heard many times before on audio monitors that we traditionally use for example to monitor sensory field responses to cutaneous stimuli. While the clicking produced by ball-ball or ball-wall contact during the estimation of *π* is "too uniform" for me to say it is directly relevant to neurophysiological population dynamics, it caused me to wonder about how this way of formulating the data from a controls theoretic stance could afford us some intuition on what is going on during otherwise complicated behavior of the system. 

---

## Motivation

There are two ways that I see the systems described in Galperin's billiards model as being helpful to motor systems neuroscience at large. They require working at the problem from "opposite" ends: one from the side of applied mathematics and one from the side of control systems engineering. Fundamentally, the improvements in understanding and descriptive capacity for measuring and comparing properties of spiking networks as well as using them as control signals by:

#### Describing neurophysiological network-level spiking activity in a coherent framework.

I would like to simplify the description of any spike train observed during movements (or, any stimulus that elicits a complex polyphasic spiking response, for that matter), so that it could be described by a basis of dynamical systems. Rather than a linear decomposition of signals into a basis of sine and cosine components (such as is done in the Fourier transformation), this method decomposes the signal by parameterizing a model based on an arbitrary number of (elastically) colliding components. 

A first order of business, from an applied mathematics standpoint, is therefore:

- [ ] **Develop a method to quickly estimate the basis system parameters from an observed sequence of impulses (spikes).**

#### Improving our ability to develop BCI controllers by providing simple engineering targets.

The engineering motivation is somewhat the opposite. Could a system based on parameters describing the distance to a wall or series of walls, the properties of collisions between that wall and masses along some axis affording contact with said wall, and arbitrary choices of mass size, initial velocities, and initial distances between colliding entities be used to generate smooth (responsive) movements to an end-point target? Because each of these things is tied to a concrete analogy, it should not be difficult to relate it to some component within the *in vivo* network and by extension use this intuition to help formulate a better BCI controller.

Put alternatively, supposing that there is a speculative distribution of positive and negative coefficient weightings on impulses within a network, which allow the generation of force along some subset of axes (i.e. muscles, which move in relation to one another). Could we use this heuristic model (**[Galperin's billiards](#who-is-galperin)**) as a starting-point to make a simple analogy for explaining what is happening with different interacting system sub-circuits during behavior? The engineering task to address is therefore:

- [ ] **Develop the simplest control system model capable of moving a segmental limb model to a target end-point while using "Galperin's Billiards" model parameters as the control signals.**

It is readily shown that this system is readily used to produce "spike-like" trains that are similar to those observed during the activation of neural units correlated to a particular movement event during behavior, as shown in **[Figure 6](#figure-6)**, below.

![](https://raw.githubusercontent.com/m053m716/Galperin-Collisions/main/img/Time-Freq_Content.png "Simulation of spike-like activity using collision model.")

##### Figure 6

> _**Proof-of-concept simulation of time-series and frequency content for collision time-series generated by model.** (Top) The time-series is simply a series of impulses inserted at the corresponding sample indices denoted by the model-determined time-of-impact between the small ball and the wall or larger ball. Each collision is denoted by an impulse; here, the impulse has been convolved with an arbitrary spike-like shape; subsequently, noise was added to the distribution (as part of a process of audio export but not necessarily having immediate value other than conditioning the smoothing esteimator--the blue line indicating approximate instantaneous firing rate--in this case). (Bottom) An analytical description of the frequency content is one of the challenges that could be addressed from the applied-math side: can we make a description of the expected frequency content produced by the system given mass, velocity, and distance-to-the wall, from the outset?_

