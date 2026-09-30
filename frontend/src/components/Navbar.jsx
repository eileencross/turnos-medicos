import { NavLink } from 'react-router-dom'
function Navbar() {
return (
<header className="navbar">
<div className="navbar__inner">
<NavLink to="/" className="navbar__brand">
Turnos Médicos
</NavLink>
<nav className="navbar__links">
<NavLink to="/" end>
Inicio
</NavLink>
<NavLink to="/medicos">Médicos</NavLink>
</nav>
</div>
</header>
)
}
export default Navbar