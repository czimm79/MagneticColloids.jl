"""
	B(r, m)

Magnetic induction field strength a distance `r` from moment `m`.
"""
function B(r, m) 
	# From biswal paper, hierarchical assemblies...
	@assert length(r) == length(m)
	
	ans = μ₀/4π * (3*(m ⋅ r) * r / norm(r)^5 - m/norm(r)^3)

	return ans .|> u"mT"
end

"""
	m(V, χ, B)
Dipole moment of a paramagnetic material with volume `V` and susceptibility `χ` in a non-magnetic medium.

"""
m(V, χ, B) = V * χ * B/μ₀ .|> upreferred

"""
	f(rᵢⱼ, mᵢ, mⱼ)
Force on dipole `mⱼ` from `mᵢ` a distance `rᵢⱼ` away.
"""
function f(rᵢⱼ, mᵢ, mⱼ)
	# from magmethods paper...
	@assert length(rᵢⱼ) == length(mᵢ) == length(mⱼ)  # all same dimensions
	
	r̂ = rᵢⱼ / norm(rᵢⱼ)
	prefactor = 3*μ₀ / (4*π*norm(rᵢⱼ)^4)
	
	A = (r̂'*mⱼ)*mᵢ + (r̂'*mᵢ)*mⱼ +(mᵢ'*mⱼ - 5*(r̂'*mᵢ)*(r̂'*mⱼ))*r̂   
	
	return prefactor * A .|> upreferred
end

"""
U(rᵢⱼ, mᵢ, mⱼ)

Potential energy between interacting dipoles `mᵢ` and `mⱼ` a distance `rᵢⱼ` away.
"""
function U(rᵢⱼ, mᵢ, mⱼ)
# from biswal heirarchical assemblies...
@assert length(rᵢⱼ) == length(mᵢ) == length(mⱼ)

μ₀/4π * (mᵢ⋅mⱼ/norm(rᵢⱼ)^3 - (3*(mᵢ⋅rᵢⱼ)*(mⱼ⋅rᵢⱼ))/norm(rᵢⱼ)^5) |> upreferred
end