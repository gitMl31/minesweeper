import Cell from './cell.jsx'
import '../css/table.css'

export default function Table () {
  return (
    <div className='gameTable'>
      <div className='scoreTable'></div>
      <div className='cellsTable'>
        <Cell />
      </div>
    </div>
  )
}
