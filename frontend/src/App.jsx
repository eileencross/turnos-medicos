import { Route, Routes } from 'react-router-dom'
import Navbar from './components/Navbar'
import Doctors from './pages/Doctors'
import Home from './pages/Home'
import NotFound from './pages/NotFound'
function App() {
return (
<>
<Navbar />
<main className="container">
<Routes>
<Route path="/" element={<Home />} />
<Route path="/medicos" element={<Doctors />} />
<Route path="*" element={<NotFound />} />
</Routes>
</main>
</>
)
}

export default App