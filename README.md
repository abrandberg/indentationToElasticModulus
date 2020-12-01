# indentationToElasticModulus
This repository takes a stiffness tensor and an indentation direction and calculates the expected indentation modulus. 


## What is this repository for?
This can be used to study the effect of

- Changes to the stiffness components.
- Changes to the indentation direction.
- Different indenter shapes.
- Inverse modeling to estimate some or all of the elastic components from a series of indentation experiments via error minimization.


## How do I get set up?
1. Clone or download this repository. The best way is to issue
     $ git clone --recurse-submodules https://github.com/abrandberg/indentationToElasticModulus.git
     
2. This repository uses the tensor manipulation library MMTensor, originally hosted at

     Maarten Moesen (2020). MMTensor 1.0 (https://www.mathworks.com/matlabcentral/fileexchange/32891-mmtensor-1-0).
     
   A copy of this repository is hosted on Github (https://github.com/abrandberg/MM_Tensor) and is included as a submodule in this repository. If you cloned the repository without recursively cloning the submodules (step 1) you can initiate the submodules manually by issuing (while standing in the *indentationToElasticModulus* repository)
   
   $ git submodule init
   
   $ git submodule update
   
 This will clone the submodule.



## Where can I read more about the equations implemented?
The basics of indentation testing is Hertzian contact mechanics. Beyond a general understanding of this topic, I recommend the following articles to understand and extend this repository:

    [1] Oliver, W. C., & Pharr, G. M. (1992). 
    An improved technique for determining hardness and elastic modulus using load and displacement sensing indentation experiments. 
    Journal of Materials Research, 7(6), 1564–1583. https://doi.org/10.1557/JMR.1992.1564

    [2] Vlassak, J. J., & Nix, W. D. (1994).
    Measuring the elastic properties of anisotropic materials by means of indentation experiments.
    Journal of the Mechanics and Physics of Solids, 42(8), 1223–1245. https://doi.org/10.1016/0022-5096(94)90033-7
    
    [3] Swadener, J. G., & Pharr, G. M. (2001). 
    Indentation of elastically anisotropic half-spaces by cones and parabolae of revolution. 
    Philosophical Magazine A, 81(2), 447–466. https://doi.org/10.1080/01418610108214314

    [4] Vlassak, J. J., Ciavarella, M., Barber, J. R., & Wang, X. (2003). 
    The indentation modulus of elastically anisotropic materials for indenters of arbitrary shape. 
    Journal of the Mechanics and Physics of Solids, 51(9), 1701–1721. https://doi.org/10.1016/S0022-5096(03)00066-8

    [5] Delafargue, A., & Ulm, F. J. (2004). 
    Explicit approximations of the indentation modulus of elastically orthotropic solids for conical indenters. 
    International Journal of Solids and Structures, 41(26), 7351–7360. https://doi.org/10.1016/j.ijsolstr.2004.06.019
    
    [6] Jäger, A., Bader, T., Hofstetter, K., & Eberhardsteiner, J. (2011). 
    The relation between indentation modulus, microfibril angle, and elastic properties of wood cell walls. 
    Composites Part A: Applied Science and Manufacturing, 42(6), 677–685. https://doi.org/10.1016/j.compositesa.2011.02.007

    [7] Argatov, I., & Mishuris, G. (2018). 
    Indentation of an Anisotropic Elastic Half-Space (pp. 323–371). https://doi.org/10.1007/978-3-319-78533-2_12

This repository currently contains an independent implementation in MATLAB of [4] and [5], verified against the curves presented in [6]. The code is **heavily un-optimized** and seeks to be similar to the actual equations in the papers. That means it is slow. If you want to get involved, I suggest that a good way to get up to speed is to go through the repository and look for optimizations. Examples include performing the integrations of ***h*** in the Fourier domain, vectorization of the Green's function, and probably many other things.


## Contribution guidelines
If you have a suggestion I propose that you contact me directly and I will try to accomodate you. You can also directly submit a pull request if you implement some additional functionality.


## Who do I talk to?

August Brandberg augustbr at k t h . s e.
