module MagneticColloids
using Unitful, LinearAlgebra

# Constants
const μ₀ = (4π * 10^-7)u"H/m"  #  absolute permittivity of free space, H/m
const kT = (1.3806503*10^-23 * 298)u"m^2*kg*s^-2"  # thermal energy at room temperature
export μ₀, kT

include("base_equations.jl")
export B, m, f, U


end
