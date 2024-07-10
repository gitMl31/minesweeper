import Cell from './cell.jsx'
import Faces from './faces.jsx'
import '../css/table.css'

export default function Table () {
  return (
    <div className='gameTable'>
      <div className='scoreTable'>
        <Faces />
      </div>
      <div className='cellsTable'>
        <Cell />
      </div>
    </div>
  )
}
