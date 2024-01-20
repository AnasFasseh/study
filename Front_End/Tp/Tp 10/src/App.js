import 'bootstrap/dist/css/bootstrap.min.css';
import ProcuctParent from './Component/ProcuctParent';
import { Route, Routes } from 'react-router-dom';
import SingleProduct from './Component/SingleProduct';
function App() {
  return (
   <Routes>
      <Route path='/' element={<ProcuctParent />}/>
      <Route path='product/:id' element={<SingleProduct />}/>
   </Routes>
  );
}

export default App;
