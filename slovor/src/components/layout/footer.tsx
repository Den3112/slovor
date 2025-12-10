import { cn } from '@/lib/utils/cn';

interface FooterProps extends React.HTMLAttributes<HTMLElement> {
  children: React.ReactNode;
}

const Footer = ({ className, children, ...props }: FooterProps) => {
  return (
    <footer
      className={cn('bg-white border-t border-gray-200 px-6 py-4', className)}
      {...props}
    >
      {children}
    </footer>
  );
};

export default Footer;