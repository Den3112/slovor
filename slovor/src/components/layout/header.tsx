import { cn } from '@/lib/utils/cn';

interface HeaderProps extends React.HTMLAttributes<HTMLElement> {
  children: React.ReactNode;
}

const Header = ({ className, children, ...props }: HeaderProps) => {
  return (
    <header
      className={cn('bg-white border-b border-gray-200 px-6 py-4', className)}
      {...props}
    >
      {children}
    </header>
  );
};

export default Header;