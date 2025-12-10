export function Footer() {
  return (
    <footer className="border-t bg-gray-50">
      <div className="container mx-auto px-4 py-8">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <div>
            <h3 className="font-semibold text-gray-900 mb-3">Slovor</h3>
            <p className="text-sm text-gray-600">
              Marketplace platform for Slovakia
            </p>
          </div>
          <div>
            <h3 className="font-semibold text-gray-900 mb-3">Links</h3>
            <ul className="space-y-2 text-sm text-gray-600">
              <li><a href="#" className="hover:text-gray-900">About</a></li>
              <li><a href="#" className="hover:text-gray-900">Contact</a></li>
              <li><a href="#" className="hover:text-gray-900">Privacy</a></li>
            </ul>
          </div>
          <div>
            <h3 className="font-semibold text-gray-900 mb-3">Built with</h3>
            <p className="text-sm text-gray-600">
              Next.js 14 + TypeScript + Supabase
            </p>
          </div>
        </div>
        <div className="mt-8 pt-8 border-t text-center text-sm text-gray-500">
          © 2025 Slovor. All rights reserved.
        </div>
      </div>
    </footer>
  )
}
