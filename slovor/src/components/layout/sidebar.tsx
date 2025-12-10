import { cn } from '@/lib/utils/cn';

interface SidebarProps extends React.HTMLAttributes<HTMLElement> {
  children: React.ReactNode;
}

const Sidebar = ({ className, children, ...props }: SidebarProps) => {
  return (
    <aside
      className={cn('bg-gray-50 border-r border-gray-200 w-64 p-4', className)}
      {...props}
    >
      {children}
    </aside>
  );
};

export default Sidebar;