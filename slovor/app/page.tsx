export default function Home() {
  return (
    <main style={{
      minHeight: '100vh',
      display: 'flex',
      flexDirection: 'column',
      alignItems: 'center',
      justifyContent: 'center',
      padding: '2rem',
      fontFamily: 'system-ui, -apple-system, sans-serif',
      background: 'linear-gradient(135deg, #667eea 0%, #764ba2 100%)',
      color: 'white',
      textAlign: 'center'
    }}>
      <h1 style={{ fontSize: '4rem', marginBottom: '1rem', fontWeight: 'bold' }}>
        Slovor 📚
      </h1>
      <p style={{ fontSize: '1.5rem', marginBottom: '2rem', opacity: 0.9 }}>
        Marketplace Platform for Slovakia
      </p>
      <div style={{
        background: 'rgba(255,255,255,0.1)',
        padding: '2rem',
        borderRadius: '1rem',
        backdropFilter: 'blur(10px)',
        maxWidth: '600px'
      }}>
        <h2 style={{ marginBottom: '1rem', fontSize: '1.5rem' }}>🚧 Development in Progress</h2>
        <p style={{ marginBottom: '0.5rem' }}>Current Phase: Foundation Setup</p>
        <p style={{ marginBottom: '0.5rem' }}>Status: Building core infrastructure</p>
        <p style={{ opacity: 0.8, marginTop: '1rem' }}>Deployment: Active on Vercel</p>
      </div>
      <p style={{ marginTop: '2rem', opacity: 0.7, fontSize: '0.9rem' }}>
        Built with Next.js 14 + TypeScript + Supabase
      </p>
    </main>
  )
}
