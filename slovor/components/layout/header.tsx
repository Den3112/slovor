export function Header() {
  return (
    <header className="border-b bg-white">
      <div className="container mx-auto px-4 py-4 flex items-center justify-between">
        <div className="flex items-center gap-2">
          <span className="text-2xl">📚</span>
          <span className="text-xl font-bold text-gray-900">Slovor</span>
        </div>
        <nav className="flex gap-6">
          <a href="#" className="text-gray-600 hover:text-gray-900 transition-colors">
            Browse
          </a>
          <a href="#" className="text-gray-600 hover:text-gray-900 transition-colors">
            Post Ad
          </a>
          <a href="#" className="text-gray-600 hover:text-gray-900 transition-colors">
            Login
          </a>
        </nav>
      </div>
    </header>
  )
}
