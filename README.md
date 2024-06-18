# ising-model
The Ising model is a mathematical tool for modelling spin-spin interactions
on a lattice of sites, where the hamiltonian is given as
$$H = -\sum_{\langle i, j \rangle} J_{i, j} \sigma_i\sigma_j - \sum_i B_i \sigma_i$$
where $\langle i, j \rangle$ denotes nearest neighbors on the lattice. The
first term corresponds to nearest neighbor interactions while the second
refers to the effect of an external magnetic field.

We present simplified 1D and 2D versions of these models, where we assume the 
external magnetic field to be zero and $J_{i, j} = 1$ for all $i, j$.

We also present a model with nonzero external magnetic field and $J_{i, j}$ which
is equal for each interaction but not necessarily 1.

Lastly, we plot the hamiltonian after thousands of iterations for various temperatures
in order to show the second-order phase transition which occurs at
$\tau = \frac{2J}{\log(1 + \sqrt 2)}$.