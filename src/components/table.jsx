import Cell from './cell.jsx'
import Faces from './faces.jsx'
import Timer from './timer.jsx'
import '../css/table.css'



export default function Table () {
  const numCell = 9
  let totalCell = numCell * numCell
  return (
    <div className='gameTable'>
      <div className='scoreTable'>
        <Timer />
        <Faces />
        <Timer />
      </div>
      <div className='cellsTable'>
        for (let index = 0; index < totalCell; index++) {
          
        }
      </div>
    </div>
  )
}
