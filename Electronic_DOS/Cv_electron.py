import numpy as np
from scipy.optimize import brentq
from scipy.interpolate import UnivariateSpline

# Constants
kB_eV = 8.617333262e-5       # eV/K
eV_to_Jmol = 96485.33212     # J/mol per eV/formula-unit
n_formula_units = 32         # 64 atoms = 32 ZrC formula units

EF = -4.659137               # eV, from SIESTA output

# Load SIESTA DOS file: column 1 = energy in eV, column 2 = DOS in states/eV/cell
data = np.loadtxt("ZrC64.DOS")
E = data[:, 0]
D = data[:, 1]

# T = 0 occupation referenced to the SIESTA Fermi level
occ0 = (E <= EF).astype(float)

def fermi(E, mu, T):
    x = (E - mu) / (kB_eV * T)
    x = np.clip(x, -700, 700)   # avoid overflow
    return 1.0 / (1.0 + np.exp(x))

def delta_N(mu, T):
    f = fermi(E, mu, T)
    return np.trapz(D * (f - occ0), E)

def chemical_potential(T):
    # bracket around EF; widen if needed
    return brentq(lambda mu: delta_N(mu, T), EF - 2.0, EF + 2.0)

def delta_U_eV_per_cell(T):
    mu = chemical_potential(T)
    f = fermi(E, mu, T)
    dU = np.trapz(E * D * (f - occ0), E)
    return dU

# Temperature grid
T_grid = np.arange(100, 3001, 25)

# Electronic excitation energy, J/mol ZrC
Uel = np.array([
    delta_U_eV_per_cell(T) / n_formula_units * eV_to_Jmol
    for T in T_grid
])

# Smooth derivative to get C_V,el
spline = UnivariateSpline(T_grid, Uel, s=0, k=3)
Cv_el = spline.derivative()(T_grid)

# Save table
out = np.column_stack([T_grid, Uel, Cv_el])
np.savetxt(
    "ZrC_electronic_heat_capacity.txt",
    out,
    header="T(K)  Delta_U_el(J/mol)  Cv_el(J/mol/K)"
)

for T, U, C in zip(T_grid[::20], Uel[::20], Cv_el[::20]):
    print(f"{T:6.1f} K   U_el={U:10.4f} J/mol   Cv_el={C:8.4f} J/mol/K")
