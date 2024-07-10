import Cell from './cell.jsx'
import Faces from './faces.jsx'
import Timer from './timer.jsx'
import '../css/table.css'

export default function Table () {
  return (
    <div className='gameTable'>
      <div className='scoreTable'>
        <Timer />
        <Faces />
        <Timer />
      </div>
      <div className='cellsTable'>
        <Cell />
      </div>
    </div>
  )
}
