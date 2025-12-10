export const metadata = {
  title: 'Slovor - In Development',
  description: 'Interactive marketplace platform for Slovakia',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="sk">
      <body>{children}</body>
    </html>
  )
}
